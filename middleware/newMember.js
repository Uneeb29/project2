import {Composer} from "grammy";
import Users from "../models/users.js";
import Group from "../models/groups.js";
import {checkUserNFT} from "../utils/on-chain.js";
import {isSuperAdmin} from "../helpers/isAdmin.js";
import {get_group} from "../queries/Groups.js";
import {get_users, user_join_group} from "../queries/User.js";

export const newMember = new Composer();

newMember.on(":new_chat_members", async (ctx) => {
  const member = ctx.message.new_chat_members[0];

  const group = get_group(ctx.chat.id);
  // skip unmanaged group
  if (group === null) {
    return;
  }

  const user = await get_users(member.id);

  if (user === null) {
    await ctx.api.banChatMember(ctx.message.chat.id, member.id);
    return;
  }

  if (group.minimum_rank > user.nft_rank) {
    await ctx.api.banChatMember(ctx.message.chat.id, member.id);
    return;
  }
  await user_join_group(user.id, ctx.chat.id);
});
