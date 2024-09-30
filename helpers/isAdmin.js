import {SUPER_ADMIN} from "../config.js";

export function isSuperAdmin(ctx) {
  return SUPER_ADMIN.includes(ctx.from?.id);
}
