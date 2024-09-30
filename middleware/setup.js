import {SUPER_ADMIN} from "../config.js";

export async function setupExtendsBot(ctx, next) {
  ctx.config = {
    isGroup: ["group", "supergroup"].includes(ctx.chat?.type),
    isSudoer: SUPER_ADMIN.includes(ctx.from?.id),
  };

  await next();
}
