import { URL } from 'url'
import { Bot, GrammyError, session, InlineKeyboard, InputFile } from "grammy";
import { BOT_TOKEN } from "./arborconfig.js";

import { get_rank_need_update } from "./queries/Rank.js";
import { get_need_pushed_task, update_task_status_to_sent } from "./queries/Tasks.js";
import { get_all_users, get_users, update_user_banned_me, update_user_task_notification } from "./queries/User.js";
import { makeNiceName } from "./utils/helper.js";

const bot = new Bot(BOT_TOKEN);

const res = {
  user_id: 2033966739,
  send_status: 0,
  name: 'Test Task',
  description: 'Check description',
  link: null,
  point: 10,
  id: 1,
  first_name: "ZekeJay || Blue-Chip Hub || Won't DM for Funds",
  last_name: null
};




const message = (res) => {
  const nicename = makeNiceName(res);

  return `
Hello ${nicename}, 
we have task <b>${res.name}</b> worth of <b>${res.point} Point Reward</b> for you :

${res.description}
`
}

const make_keyboard = (data) => {
  const keyboard = new InlineKeyboard();

  if (data.type === 'MARK_AS_DONE') {
    keyboard.text("✅ TASK DONE", `complete_task ${data.id}`)
  }

  if (data.type === 'NEED_USER_PROOF') {
    keyboard.text("✅ TASK DONE", `proof_task ${data.id}`)
  }
  return keyboard
}

const main = async () => {
  const data = await get_all_users();
  console.log(data.length)

  for (let i = 0; i < data.length; i++) {
    try {
      const res = await bot.api.getChat(data[i].id)
      console.log(res);
    } catch (error) {
      await update_user_banned_me(data[i].id);
      console.log(error)
    }
  }

}

// const interval = 10 * 1000
main()
