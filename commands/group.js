import { Composer } from "grammy";
import { checkIfSuperAdmin } from "../middleware/checkIfSuperAdmin.js";
import Groups from "../models/groups.js";
import Users from "../models/users.js";
import { downgradeRank, removeUserNFT, upgradeRank } from "../utils/on-chain.js";
import { makeNiceName } from "../utils/helper.js";
import { delete_group, get_group, insert_group, update_minimum_rank } from "../queries/Groups.js";
import { get_user_groups, get_users, kick_user_group, remove_user_group, update_user_nft_rank } from "../queries/User.js";

export const groupHandler = new Composer();

const helpMessage = `
<b>Welcome To Bot!</b>

<b>Group Common Command :</b>

/help
<pre>Display this message</pre>

/adminhelp
<pre>Display admin help message</pre>

`;

const superAdminHelp = `
<b>Super Admin Only Command</b>

/register
<pre>Set this group managed</pre>

/unregister
<pre>Set this group unmanaged</pre>

/minrank minimum_rank
<pre>Set minimum rank to join this group</pre>

/ban replied_to_user_message
<pre>Ban User from community</pre>

/upgrade replied_to_user_message
<pre>Upgrade NFT Rank User</pre>

/downgrade replied_to_user_message
<pre>Downgrade NFT Rank User</pre>
`;

// groupHandler.use(async (ctx, next) => {
//   console.log("group chat", ctx);
// });

groupHandler.command("help", async (ctx) => {
  console.log("group chat", ctx);
  await ctx.reply(helpMessage, {
    parse_mode: "HTML",
  });
});

groupHandler.command("adminhelp", checkIfSuperAdmin, async (ctx) => {
  await ctx.reply(superAdminHelp, {
    parse_mode: "HTML",
  });
});

groupHandler.command("register", checkIfSuperAdmin, async (ctx) => {
  const groupDb = await get_group(ctx.chat.id);

  if (groupDb !== null) {
    await ctx.reply(`Group <b>${ctx.chat.title}</b> already on database`, {
      parse_mode: "HTML",
    });
    return;
  }
  try {
    const invitelink = await ctx.api.createChatInviteLink(ctx.chat.id);
  } catch (error) {
    await ctx.reply(`Sorry I cannot manage this group, because I'm not Admin`, {
      parse_mode: "HTML",
    });
    return;
  }
  try {
    await insert_group(ctx.chat.id, ctx.chat.title, ctx.chat.username);
    await ctx.reply(`Group <b>${ctx.chat.title}</b> successfully managed`, {
      parse_mode: "HTML",
    });
  } catch (error) {
    console.log(error);
    await ctx.reply(`App Error`, {
      parse_mode: "HTML",
    });
  }
});

groupHandler.command("unregister", checkIfSuperAdmin, async (ctx) => {
  const groupDb = await get_group(ctx.chat.id);
  if (groupDb === null) {
    await ctx.reply(`Group <b>${ctx.chat.title}</b> already unmanaged`, {
      parse_mode: "HTML",
    });
    return;
  }

  await delete_group(ctx.chat.id);

  await ctx.reply(`Group <b>${ctx.chat.title}</b> successfully unmanaged`, {
    parse_mode: "HTML",
  });
});

groupHandler.command("minrank", checkIfSuperAdmin, async (ctx) => {
  const groupDb = await get_group(ctx.chat.id);
  if (groupDb === null) {
    await ctx.reply(`This group is not registered, please use /register command to register this group`, {
      parse_mode: "HTML",
    });
    return;
  }

  if (ctx.match === "") {
    await ctx.reply(
      `missing or wrong <code>minimum rank</code>
please use command like : <code>/minrank 1</code>`,
      {
        parse_mode: "HTML",
      }
    );
    return;
  }
  const minRank = Number(ctx.match);
  if (minRank > 0 && minRank < 11) {
    await update_minimum_rank(ctx.chat.id, minRank);

    await ctx.reply(`minimum rank successfully set to ${minRank}`, {
      parse_mode: "HTML",
    });
    return;
  }

  await ctx.reply(
    `missing or wrong <code>minimum rank</code>
please use command like : <code>/minrank 1</code>
rank must between 1 to 10`,
    {
      parse_mode: "HTML",
    }
  );
});

groupHandler.command("ban", checkIfSuperAdmin, async (ctx) => {
  const groupDb = await get_group(ctx.chat.id);
  if (groupDb === null) {
    await ctx.reply(`This group is not registered, please use /register command to register this group`, {
      parse_mode: "HTML",
    });
    return;
  }
  if (typeof ctx.message.reply_to_message === "undefined") {
    await ctx.reply(`please specify user to ban, with reply to their message`);
    return;
  }
  const replied = ctx.message.reply_to_message;

  const user = await get_users(replied.from.id);
  //remove nft

  const isRemoved = await removeUserNFT(user.generated_address);

  if (!isRemoved) {
  }

  const joined = await get_user_groups(user.id);
  for (let i = 0; i < joined.length; i++) {
    try {
      await ctx.api.banChatMember(joined[i].group_id, user.id);
    } catch (error) {
      console.log(error);
    }
  }
  try {
    await Promise.all([kick_user_group(user.id), update_user_nft_rank(user.id, 0)]);
  } catch (error) {
    console.log(error);
  }

  await ctx.reply(`User ${makeNiceName(replied.from)}  has been banned`);

  return;
});

groupHandler.command("upgrade", checkIfSuperAdmin, async (ctx) => {
  const groupDb = await get_group(ctx.chat.id);
  if (groupDb === null) {
    await ctx.reply(`This group is not registered, please use /register command to register this group`, {
      parse_mode: "HTML",
    });
    return;
  }
  if (typeof ctx.message.reply_to_message === "undefined") {
    await ctx.reply(`please specify user to upgrade, with reply to their message`);
    return;
  }
  const replied = ctx.message.reply_to_message;

  const user = await get_users(replied.from.id);

  // upgrade nft rank

  if (user.rank === 10) {
    await ctx.reply(`User ${makeNiceName(replied.from)}  already have max rank`);
    return;
  }

  const isUpgraded = await upgradeRank(user.generated_address, user.nft_rank, user.nft_rank + 1);

  if (isUpgraded === "") {
    await ctx.reply(`Cannot upgrade user ${makeNiceName(replied.from)}, maybe not enough gas fee`);
    return;
  }

  await update_user_nft_rank(user.id, user.nft_rank + 1);
  await ctx.reply(`User ${makeNiceName(replied.from)}  has been upgraded to rank <b>${user.rank}</b>`, {
    parse_mode: "HTML",
  });

  return;
});

groupHandler.command("downgrade", checkIfSuperAdmin, async (ctx) => {
  const groupDb = await get_group(ctx.chat.id);
  if (groupDb === null) {
    await ctx.reply(`This group is not registered, please use /register command to register this group`, {
      parse_mode: "HTML",
    });
    return;
  }
  if (typeof ctx.message.reply_to_message === "undefined") {
    await ctx.reply(`please specify user to downgrade, with reply to their message`);
    return;
  }
  const replied = ctx.message.reply_to_message;

  const user = await get_users(replied.from.id);

  // upgrade nft rank

  if (user.rank === 1) {
    await ctx.reply(`User ${makeNiceName(replied.from)} already lowest rank`);
    return;
  }

  const newRank = user.rank - 1;

  const isDowngraded = await downgradeRank(user.generated_address, user.nft_rank, newRank);

  if (isDowngraded === "") {
    await ctx.reply(`Cannot downgrade user ${makeNiceName(replied.from)}, maybe not enough gas fee`);
    return;
  }

  // check if current group is below new rank
  let joined = get_user_groups(user.id);

  for (let i = 0; i < joined.length; i++) {
    const user_group = await get_group(joined[i].group_id);

    if (user_group[i].minimum_rank > newRank) {
      await ctx.api.banChatMember(user_group[i].group_id, user.id);
      await remove_user_group(user_group[i].id);
    }
  }

  await update_user_nft_rank(user.id, newRank);

  await ctx.reply(`User ${makeNiceName(replied.from)} has been downgraded to rank <b>${user.rank}</b>`, {
    parse_mode: "HTML",
  });

  return;
});
