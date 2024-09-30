import { Composer, InlineKeyboard } from "grammy";
import Users from "../models/users.js";
import Groups from "../models/groups.js";
import Settings from "../models/settings.js";
import { privateKeyToAddress, validAddress } from "../utils/wallet-generator.js";
import { mintFreeNFT } from "../utils/on-chain.js";
import {
  get_setting,
  update_setting_is_testnet,
  update_setting_nft_address,
  update_setting_private_key,
  update_setting_rpc_url,
} from "../queries/Setting.js";
import { get_users_stats } from "../queries/User.js";

const helpMessage = `
<b>Admin Help Command!</b>

/help
<pre>Display this message</pre>

/wallet
<pre>Display your wallet</pre>

/groups
<pre>Display Group List</pre>

/stats
<pre>Display Statistic</pre>

/adminhelp
<pre>Display admin help message</pre>

/setting
<pre>Display current setting</pre>

/setprivatekey [privatekey]
<pre>Change Private Key of Bot</pre>

/setnftaddress [nftaddress]
<pre>Change NFT Address of Bot</pre>

/setrpcaddress [rpcaddress]
<pre>Change RPC Address</pre>

/settestnet [true|false]
<pre>Change Testnet mode of Bot</pre>

/givenft [address] [rank]
<pre>Give User NFT</pre>
`;

export const privateAdminHandler = new Composer();

privateAdminHandler.command("adminhelp", async (ctx) => {
  ctx.reply(helpMessage, { parse_mode: "HTML" });
});

privateAdminHandler.command("stats", async (ctx) => {
  const { total, rank0, rank1, rank2, rank3, rank4, rank5, rank6, rank7, rank8, rank9, rank10 } = await get_users_stats();

  await ctx.reply(
    `<b>Bot Statistic :</b>

👤 User :
<pre>
Rank 0 : ${rank0}
Rank 1 : ${rank1}
Rank 2 : ${rank2}
Rank 3 : ${rank3}
Rank 4 : ${rank4}
Rank 5 : ${rank5}
Rank 6 : ${rank6}
Rank 7 : ${rank7}
Rank 8 : ${rank8}
Rank 9 : ${rank9}
Rank 10 : ${rank10}
</pre>

Total User : ${total}

`,
    { parse_mode: "HTML" }
  );
});

privateAdminHandler.command("setting", async (ctx) => {
  const settings = await get_setting();

  await ctx.reply(
    `<b>Current Settings:</b>
<pre>
Private Key : ${settings.private_key} 
Address     : ${privateKeyToAddress(settings.private_key)} 

NFT Address : ${settings.nft_address} 
Is Tesnet   : ${settings.is_testnet === 1 ? "Yes" : "No"} 
RPC URL     : ${settings.rpc_url} 
</pre>`,
    { parse_mode: "HTML" }
  );
});

privateAdminHandler.command("settestnet", async (ctx) => {
  const settings = await get_setting();

  const newConfig = ctx.match;
  if (!["true", "false"].includes(newConfig)) {
    await ctx.reply(
      `<b>Invalid testnet setting!</b>
<pre>
Valid setting: true | false
</pre>`,
      { parse_mode: "HTML" }
    );
    return;
  }

  settings.is_testnet = newConfig === "true" ? 1 : 0;
  await update_setting_is_testnet(settings.is_testnet);

  await ctx.reply(
    `<b>Setting saved !</b>

<b>Current Settings:</b>
<pre>
Private Key : ${settings.private_key} 
Address     : ${privateKeyToAddress(settings.private_key)} 

NFT Address : ${settings.nft_address} 
Is Tesnet   : ${settings.is_testnet === 1 ? "Yes" : "No"} 
RPC URL     : ${settings.rpc_url} 
</pre>`,
    { parse_mode: "HTML" }
  );
});

privateAdminHandler.command("setnftaddress", async (ctx) => {
  const settings = await get_setting();

  const newConfig = ctx.match;
  if (!validAddress(newConfig)) {
    await ctx.reply(`<b>You input Invalid Contract Address!</b>`, {
      parse_mode: "HTML",
    });
    return;
  }

  settings.nft_address = newConfig;
  await update_setting_nft_address(newConfig);

  await ctx.reply(
    `<b>Setting saved !</b>

<b>Current Settings:</b>
<pre>
Private Key : ${settings.private_key} 
Address     : ${privateKeyToAddress(settings.private_key)} 

NFT Address : ${settings.nft_address} 
Is Tesnet   : ${settings.is_testnet === 1 ? "Yes" : "No"} 
RPC URL     : ${settings.rpc_url} 
</pre>`,
    { parse_mode: "HTML" }
  );
});

privateAdminHandler.command("setrpcaddress", async (ctx) => {
  const settings = await get_setting();
  const newConfig = ctx.match;
  if (newConfig === "") {
    await ctx.reply(`<b>You input Invalid RPC Address!</b>`, {
      parse_mode: "HTML",
    });
    return;
  }
  settings.rpc_url = newConfig;
  await update_setting_rpc_url(newConfig);

  await ctx.reply(
    `<b>Setting saved !</b>

<b>Current Settings:</b>
<pre>
Private Key : ${settings.private_key} 
Address     : ${privateKeyToAddress(settings.private_key)} 

NFT Address : ${settings.nft_address} 
Is Tesnet   : ${settings.is_testnet === 1 ? "Yes" : "No"} 
RPC URL     : ${settings.rpc_url} 
</pre>`,
    { parse_mode: "HTML" }
  );
});

privateAdminHandler.command("setprivatekey", async (ctx) => {
  const settings = await get_setting();

  const newConfig = ctx.match;
  if (newConfig.length !== 64) {
    await ctx.reply(
      `<b>You input Invalid Private Key!</b>
<pre>
please input private key without 0x format
also private key length must be 64 char

if private key not 64 char, just add leading zero
</pre>
    `,
      { parse_mode: "HTML" }
    );
    return;
  }

  settings.private_key = newConfig;
  await update_setting_private_key(newConfig);

  await ctx.reply(
    `<b>Setting saved !</b>

<b>Current Settings:</b>
<pre>
Private Key : ${settings.private_key} 
Address     : ${privateKeyToAddress(settings.private_key)} 

NFT Address : ${settings.nft_address} 
Is Tesnet   : ${settings.is_testnet === 1 ? "Yes" : "No"} 
RPC URL     : ${settings.rpc_url} 
</pre>`,
    { parse_mode: "HTML" }
  );
});

privateAdminHandler.command("givenft", async (ctx) => {
  const settings = await get_setting();

  const args = ctx.match;
  const [address, rank] = args.split(" ");
  if (!validAddress(address)) {
    await ctx.reply(`<b>You input Invalid Receiver Address!</b>`, {
      parse_mode: "HTML",
    });
    return;
  }

  if (Number(rank > 10 || rank < 1)) {
    await ctx.reply(`<b>You input Invalid Rank!</b>`, { parse_mode: "HTML" });
    return;
  }

  const isMember = await Users.findOne({ address: address });
  if (isMember === null) {
    await ctx.reply(`<b>Address you give is not member!</b>`, {
      parse_mode: "HTML",
    });
    return;
  }

  if (isMember.rank > 0) {
    await ctx.reply(`<b>${isMember.first_name} ${isMember.last_name}</b> is already have NFT`, { parse_mode: "HTML" });
    return;
  }

  const tx = await mintFreeNFT(address, rank);
  if (tx === rank) {
    isMember.rank = rank;
    await isMember.save();

    await ctx.reply(`<b>Mint NFT failed, user already have NFT!</b>`, {
      parse_mode: "HTML",
    });
  } else if (tx !== "") {
    isMember.rank = rank;
    await isMember.save();

    await ctx.reply(`<b>Mint NFT Success!</b>`, {
      parse_mode: "HTML",
      reply_markup: new InlineKeyboard().url("View Tx", tx),
    });
  } else {
    await ctx.reply(`<b>Mint NFT Failed! check if bot address doesnt have gas!</b>`, { parse_mode: "HTML" });
  }
  return;
});
