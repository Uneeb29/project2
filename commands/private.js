import {Composer, InlineKeyboard} from "grammy";
import {generateWallet} from "../utils/wallet-generator.js";
import {createAddressLink, makeNiceName} from "../utils/helper.js";
import {mintFreeNFT} from "../utils/on-chain.js";
import {get_users, insert_user} from "../queries/User.js";
import {get_setting} from "../queries/Setting.js";
import {get_all_group, get_group, update_group_id} from "../queries/Groups.js";
import {get_rank_table, get_user_task_point} from "../queries/Tasks.js";
import {get_active_campaign, get_active_campaign_by_id, check_if_blacklisted, get_leaderboard} from "../queries/Campaign.js";
import {active_campaign_keyboard} from "../utils/keyboard.js";

export const privateHandler = new Composer();

const helpMessage = `
<b>Welcome To ArborBot!</b>

/help
<pre>Display this message</pre>

/tutorial
<pre>Display ArborBot tutorial video</pre>

/campaign
<pre>Display active campaigns</pre>

/profile
<pre>Display your profile</pre>

/groups
<pre>Display Group List</pre>

/point
<pre>Display your Point from task</pre>

/adminhelp
<pre>Display admin help message</pre>
`;

privateHandler.command(["help", "start"], async (ctx) => {
  console.log(ctx);
  const startParam = ctx.match; // get the payload from the start command
  console.log({startParam});
  const user_id = ctx.message.from.id;

  if (startParam) {
    const [id, campaign_id] = startParam.split("_");
    const is_blacklisted = await check_if_blacklisted(user_id);
    if (is_blacklisted) {
      await ctx.reply(`Sorry, you are blacklisted from this campaign`);
      return;
    }

    // Check if the campaign ID is valid
    const active_campaign = await get_active_campaign_by_id(campaign_id);
    console.log({active_campaign});
    if (active_campaign) {
      const keyboard = await active_campaign_keyboard(campaign_id);
      await ctx.reply(`Welcome to ArborBot campaign, please select from the list below:`, {
        parse_mode: "HTML",
        reply_markup: keyboard,
      });
    } else {
      await ctx.reply(`Sorry, the campaign you are trying to access is not available.`);
    }
  } else {
    await ctx.reply(helpMessage, {parse_mode: "HTML"});
  }
});

privateHandler.command("help", async (ctx) => {
  await ctx.reply(helpMessage, {parse_mode: "HTML"});
});

privateHandler.command("tutorial", async (ctx) => {
  await ctx.reply(`https://youtu.be/Z3pX28XxXjU`, {parse_mode: "HTML"});
});

privateHandler.command("profile", async (ctx) => {
  const user = await get_users(ctx.message.from.id);
  const setting = await get_setting();
  let known_user = user;
  const user_id = ctx.message.from.id;
  const is_blacklisted = await check_if_blacklisted(user_id);
  if (is_blacklisted) {
    await ctx.reply(`Sorry, you are blacklisted from this campaign`);
    return;
  }

  if (user === null) {
    const new_user = ctx.message.from;
    const new_wallet = generateWallet();

    new_user.private_key = new_wallet.privateKey;
    new_user.generated_address = new_wallet.address;

    await mintFreeNFT(new_wallet.address, 1);
    new_user.nft_rank = 1;

    await insert_user(new_user);

    known_user = new_user;
  }

  const addressLink = createAddressLink(known_user.generated_address, setting.is_testnet);

  const keyboard = new InlineKeyboard();

  keyboard.url("NFT WALLET", addressLink);

  if (known_user.email === null || typeof known_user.email === "undefined") {
    keyboard.text("✉️ Set Email", "update_email");
  } else {
    keyboard.text("✉️ Update Email", "update_email");
  }

  if (known_user.twitter === null || typeof known_user.twitter === "undefined") {
    keyboard.text("🐦 Set Twitter", "update_twitter");
  } else {
    keyboard.text("🐦 Update Twitter", "update_twitter");
  }
  keyboard.row();

  if (known_user.owner_address === null || typeof known_user.owner_address === "undefined") {
    keyboard.text("💰 Set Personal Wallet", "update_wallet");
  } else {
    keyboard.text("💰 Update Personal Wallet", "update_wallet");
  }

  if (known_user.rank === 0) {
    keyboard.text("Mint NFT", "mint_nft");
  }

  if (known_user.enable_task === 0) {
    keyboard.text("🔔 Enable Daily Task", "toggle_task");
  }

  if (known_user.enable_task === 1) {
    keyboard.text("🔕 Disable Daily Task", "toggle_task");
  }

  const nicename = makeNiceName(ctx.message.from);
  await ctx.reply(
    `Hello <b>${nicename}</b>
<pre>
👤  Username         : ${known_user.username}
✉️  Email            : ${
      known_user.email === null || typeof known_user.email === "undefined" ? "🚫 NOT SET" : known_user.email
    }
🐦  Twitter Username : ${
      known_user.twitter === null || typeof known_user.twitter === "undefined" ? "🚫 NOT SET" : known_user.twitter
    }
💵  NFT Wallet       : ${known_user.generated_address}
🌳  NFT Rank         : ${known_user.nft_rank}
💰  Personal Wallet  : ${
      known_user.owner_address === null || typeof known_user.owner_address === "undefined"
        ? "🚫 NOT SET"
        : known_user.owner_address
    }
📃  Daily Task    : ${
      known_user.enable_task === 0 || typeof known_user.enable_task === "undefined" ? "🔕 Disabled" : "🔔 Enabled"
    }
    
</pre>
`,
    {
      parse_mode: "HTML",
      reply_markup: keyboard,
    }
  );
});

const createKeyboard = (data) => {
  const keyboard = new InlineKeyboard();

  for (let i = 0; i < data.length; i++) {
    keyboard.url(data[i].title.toUpperCase(), data[i].invite);
    keyboard.row();
  }

  return keyboard;
};

// create handler to show group list based on database
privateHandler.command("groups", async (ctx) => {
  const group = await get_all_group();

  const user = await get_users(ctx.from.id);

  const is_blacklisted = await check_if_blacklisted(user_id);
  if (is_blacklisted) {
    await ctx.reply(`Sorry, you are blacklisted from this campaign`);
    return;
  }
  // console.log({ user })
  if (typeof user?.nft_rank === "undefined" || user?.nft_rank === null) {
    user.nft_rank = 0;
    await update_user_nft_rank(user.id, user.nft_rank);
  }

  let allGroup = [];

  for (let i = 0; i < group.length; i++) {
    if (group[i].minimum_rank > user.nft_rank) {
      continue;
    }
    try {
      const inviteLink = await ctx.api.createChatInviteLink(group[i].id);
      allGroup.push({
        id: group[i].id,
        title: group[i].title,
        minRank: group[i].minimum_rank,
        invite: inviteLink.invite_link,
      });
    } catch (error) {
      console.log(`group error : `, error);
      if (error.description.includes("group chat was upgraded to a supergroup chat")) {
        await update_group_id(group[i].id, error.parameters.migrate_to_chat_id);
      }
      continue;
    }
  }
  await ctx.reply(`List of available groups you can join :`, {
    parse_mode: "HTML",
    reply_markup: createKeyboard(allGroup),
  });
});

privateHandler.command("point", async (ctx) => {
  const user_id = ctx.from.id;

  const is_blacklisted = await check_if_blacklisted(user_id);
  if (is_blacklisted) {
    await ctx.reply(`Sorry, you are blacklisted from this campaign`);
    return;
  }
  const user_point = await get_user_task_point(user_id);
  const rank_table = await get_rank_table();
  // console.log({ rank_table })
  // const next_rank = user_point.nft_rank + 1
  const next_rank = user_point.nft_rank === 0 ? 1 : user_point.nft_rank;

  await ctx.reply(
    `Current Ranks : <b>${user_point.nft_rank}</b>
Points : <b>${user_point.user_point}</b>
Points needed to reach next Ranks: <b>${rank_table[next_rank].minimum_point - user_point.user_point}</b>

`,
    {
      parse_mode: "HTML",
    }
  );
});

privateHandler.command("campaign", async (ctx) => {
  const user_id = ctx.from.id;

  // const is_blacklisted = await check_if_blacklisted(user_id);
  // if (is_blacklisted) {
  //   await ctx.reply(`Sorry, you are blacklisted from this campaign`);
  //   return;
  // }
  const active_campaign = await get_active_campaign();
  const keyboard = await active_campaign_keyboard();
  if (active_campaign === null) {
    await ctx.reply(`Sorry there's no campaign for now`);
    return;
  }
  await ctx.reply(`Welcome to ArborBot campaign, please select from list below :`, {
    parse_mode: "HTML",
    reply_markup: keyboard,
  });
});

privateHandler.command("leaderboard", async (ctx) => {
  const user_id = ctx.from.id;

  const is_blacklisted = await check_if_blacklisted(user_id);
  if (is_blacklisted) {
    await ctx.reply(`Sorry, you are blacklisted from this campaign`);
    return;
  }
  const response = await get_leaderboard(user_id);
  // console.log({ userPoint, userId })
  let message = `Leaderboard : \n \n ${response}`;
  await ctx.reply(message);
}
);
