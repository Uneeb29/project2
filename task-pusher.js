import { URL } from 'url'
import { Bot, GrammyError, session, InlineKeyboard, InputFile } from "grammy";
import { BOT_TOKEN } from "./arborconfig.js";

import { get_rank_need_update } from "./queries/Rank.js";
import { get_need_pushed_task, update_task_status_to_sent } from "./queries/Tasks.js";
import { get_users, update_user_task_notification } from "./queries/User.js";
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
we have a task worth <b>${res.point} Point</b> for you : <b>${res.name}</b>

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

  // 'MARK_AS_DONE','NEED_USER_PROOF','TWITTER_PROOF','IMAGE_PROOF','LINK_PROOF'

  if (data.type === 'TWITTER_PROOF') {
    keyboard.text("✅ TASK DONE", `proof_task_twitter ${data.id}`)
  }

  if (data.type === 'IMAGE_PROOF') {
    keyboard.text("✅ TASK DONE", `proof_task_image ${data.id}`)
  }

  if (data.type === 'LINK_PROOF') {
    keyboard.text("✅ TASK DONE", `proof_task_link ${data.id}`)
  }

  return keyboard
}

const main = async () => {
  const data = await get_need_pushed_task();
  if (data === null) {
    console.log(`no data for now`);
    return;
  }

  for (let i = 0; i < data.length; i++) {
    // if (data[i].user_id !== 5551242261 || data[i].user_id !== 560285695) {
    //   await update_task_status_to_sent(data[i].id);
    //   continue;
    // }
    console.log(data[i])
    const result = message(data[i])
    const keyboard = make_keyboard(data[i])
    try {

      if (data[i].images === null || data[i].images === '') {
        await bot.api.sendMessage(data[i].user_id, result, {
          parse_mode: "HTML",
          reply_markup: keyboard,
        });
      } else {
        await bot.api.sendPhoto(data[i].user_id, new InputFile({
          url: `https://arborbotadmin.arborswap.org/assets/uploads/${data[i].images}`
        }), {
          caption: result,
          parse_mode: "HTML",
          reply_markup: keyboard,
        });

      }


      await update_task_status_to_sent(data[i].id);
      console.log(`success sent to ${makeNiceName(data[i])}`)
    } catch (error) {
      if (error.description.includes("bot was blocked by the user")) {
        await update_user_task_notification(data[i].user_id, 0);
        await update_task_status_to_sent(data[i].id);
        console.log(error);
      }

      if (error.description.includes("chat not found")) {
        await update_user_task_notification(data[i].user_id, 0);
        await update_task_status_to_sent(data[i].id);
        console.log(error);
      }

      if (error.description.includes("Forbidden: user is deactivated")) {
        await update_user_task_notification(data[i].user_id, 0);
        await update_task_status_to_sent(data[i].id);
        console.log(error);
      }
      console.log(error);
    }
  }
}

const interval = 60 * 1000
main();
setInterval(() => {
  main();
}, interval);
