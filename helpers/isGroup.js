export function isGroup(ctx) {
  return ["group", "supergroup"].includes(ctx.chat?.type);
}
