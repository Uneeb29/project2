import { Bot, GrammyError, session } from "grammy";
import { BOT_TOKEN } from "./arborconfig.js";
import { groupHandler } from "./commands/group.js";
import { privateHandler } from "./commands/private.js";
import { addedToGroups } from "./middleware/addedToGroups.js";
import { setupExtendsBot } from "./middleware/setup.js";
import { newMember } from "./middleware/newMember.js";
import { checkIfSuperAdmin } from "./middleware/checkIfSuperAdmin.js";
import { privateAdminHandler } from "./commands/private-admin.js";
import { callbackHandler } from "./commands/callback.js";
import { insert_chat, insert_message } from "./queries/Message.js";

const bot = new Bot(BOT_TOKEN);
// console.log({ bot })
bot.use(
  session({
    initial() {
      return {};
    },
  })
);
bot.use(setupExtendsBot);
bot.use(addedToGroups);

bot.use(async (ctx, next) => {
  // console.log(ctx);
  // console.log(ctx.message.date.toLocaleString(), ctx)

  if (typeof ctx.chat !== 'undefined') {
    await insert_chat(ctx.chat);
  }

  if (typeof ctx.message !== 'undefined') {

    const user_id = ctx.message.from.id;
    const chat_id = ctx.message.chat.id;
    const text = ctx.message.text;
    const entities = ctx.message.entities;
    const dates = ctx.message.date;

    await insert_message({
      chat_id,
      user_id,
      text,
      entities,
      dates,
    });
  }
  await next();
});

const group = bot.chatType(["group", "supergroup"]);
const pm = bot.chatType("private");

group.use(newMember);
group.use(groupHandler);
pm.use(privateHandler);
pm.use(callbackHandler);

pm.use(checkIfSuperAdmin, privateAdminHandler);

group.command("ban", async (ctx) => {
  console.log(ctx.message);
});

bot.catch((err) => {
  const ctx = err.ctx;
  console.error(`Error while handling update ${ctx.update.update_id}:`, ctx);
  const e = err.error;
  if (e instanceof GrammyError) {
    console.error("Error in request:", e.description);
  } else {
    console.error("Unknown error:", e);
  }
});
console.log(`bot started`)
bot.start();
// Enable graceful stop
process.once("SIGINT", () => bot.stop("SIGINT"));
process.once("SIGTERM", () => bot.stop("SIGTERM"));
