export function isPrivate(ctx) {
  return ctx.chat?.type === "private";
}
