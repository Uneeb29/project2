import {isSuperAdmin} from "../helpers/isAdmin.js";

export async function checkIfSuperAdmin(ctx, next) {
  if (!isSuperAdmin(ctx)) {
    await ctx.reply("This command only for Super Admin");
    return;
  }
  await next();
}
