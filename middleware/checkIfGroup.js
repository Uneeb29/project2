import {isGroup} from "../helpers/isGroup.js";

export async function checkIfGroup(ctx, next) {
  if (!isGroup(ctx)) {
    return;
  }
  await next();
}
