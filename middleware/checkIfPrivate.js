import {isPrivate} from "../helpers/isPrivate.js";

export async function checkIfPrivate(ctx, next) {
  if (!isPrivate(ctx)) {
    return;
  }
  await next();
}
