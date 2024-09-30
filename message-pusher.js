import { URL } from 'url'
import { Bot, GrammyError, session, InlineKeyboard, InputFile } from "grammy";
import { BOT_TOKEN } from "./arborconfig.js";

import { get_rank_need_update } from "./queries/Rank.js";
import { get_need_pushed_task, update_task_status_to_sent } from "./queries/Tasks.js";
import { get_users, update_user_task_notification } from "./queries/User.js";
import { makeNiceName } from "./utils/helper.js";
import { get_notification_to_user, update_notification_to_user } from './queries/Campaign.js';

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


const main = async () => {
  const data = await get_notification_to_user();
  if (data === null) {
    console.log(`no data for now`);
    return;
  }

  for (let i = 0; i < data.length; i++) {
    console.log(data[i])

    try {


      await bot.api.sendMessage(data[i].user_id, data[i].message_text, {
        parse_mode: "HTML"
      });

      await update_notification_to_user(data[i].id);
      console.log('notification success sent')
    } catch (error) {
      console.log(error)
      if (error.description.includes("bot was blocked by the user")) {
        await update_notification_to_user(data[i].id);
        console.log(error);
      }

      if (error.description.includes("chat not found")) {
        await update_notification_to_user(data[i].id);
        console.log(error);
      }

      if (error.description.includes("Forbidden: user is deactivated")) {
        await update_notification_to_user(data[i].id);
        console.log(error);
      }
      if (error.description.includes("Bad Request: message text is empty")) {
        await update_notification_to_user(data[i].id);
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
