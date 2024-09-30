import { Composer } from "grammy";
import { get_group } from "../queries/Groups.js";

export const addedToGroups = new Composer();

addedToGroups.on(":new_chat_members:me", async (ctx) => {
  if (ctx.config.isSudoer) {
    await ctx.reply(
      `Hello, I am a bot that can help you to manage your group. 
You can use /help to see the list of commands that I can do.`
    );
  } else {
    await ctx.reply(`Sorry I can't help you.`);
    await ctx.leaveChat();
  }
});

addedToGroups.on(":left_chat_member:me", async (ctx) => {
  const group = await get_group(ctx.chat.id);

  if (groupDb === null) {
    return;
  }

  await delete_group(ctx.chat.id);

});

addedToGroups.on(":supergroup_chat_created", async (ctx) => {
  console.log({
    log: "supergroup_chat_created",
    chat: ctx.chat,
    from: ctx.from,
    sender: ctx.senderChat,
  });
});

addedToGroups.on(":migrate_from_chat_id", async (ctx) => {
  // const old_id = ctx.chat.id;
  // const new_id = ctx.message.mi;
  console.log(ctx);
  console.log({
    log: "migrate_from_chat_id",
    chat: ctx.chat,
    from: ctx.from,
    sender: ctx.senderChat,
  });
});
