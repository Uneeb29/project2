import { Bot, GrammyError, session, InlineKeyboard } from "grammy";
import { BOT_TOKEN } from "./arborconfig.js";
import { get_user_rank_need_process, update_processed_rank } from "./queries/Rank.js";
import { giveFreeNFT, upgradeRank, checkUserNFT } from "./utils/on-chain.js";
import { makeNiceName } from "./utils/helper.js";
const bot = new Bot(BOT_TOKEN);
const ARBOR_GROUP_ID = -1001682502657;

const message = (new_rank) => {
  return `Congratulations! 🥳
By completing the daily tasks, you have increased in rank!
your now upgraded to rank (${new_rank})`
}

const public_message = (data) => {
  return `Congratulations <a href="tg://user?id=${data.user_id}">${makeNiceName(data)}</a>, you’ve increased in rank and now upgraded to Rank <b>(${data.new_rank})</b>`
}

const main = async () => {
  try {
    const data = await get_user_rank_need_process();
    console.log({ data })
    if (data === null) {
      return;
    }

    const existingRank = await checkUserNFT(data.generated_address, data.old_rank);
    console.log({ existingRank })
    let tx_hash = "";
    if (existingRank === 0) {
      tx_hash = await giveFreeNFT(data.generated_address, data.new_rank);
    } else if (existingRank === data.new_rank) {
      tx_hash = "done"
    }
    else {
      tx_hash = await upgradeRank(data.generated_address, data.old_rank, data.new_rank);
    }
    if (tx_hash === "") {
      return;
    }
    console.log({ tx_hash })
    const res = await update_processed_rank(data.id, data.user_id, data.new_rank, tx_hash);
    const send_message = message(data.new_rank);
    const public_send_message = public_message(data);

    if (res) {
      try {
        await bot.api.sendMessage(data.user_id, send_message, {
          parse_mode: "HTML",
        });
        console.log('update new rank success :', data.id)
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

      try {
        await bot.api.sendMessage(ARBOR_GROUP_ID, public_send_message, {
          parse_mode: "HTML",
        });
        console.log('update new rank success :', data.id)
      } catch (error) {
        // if (error.description.includes("bot was blocked by the user")) {
        //   await update_user_task_notification(data[i].user_id, 0);
        //   await update_task_status_to_sent(data[i].id);
        //   console.log(error);
        // }

        // if (error.description.includes("chat not found")) {
        //   await update_user_task_notification(data[i].user_id, 0);
        //   await update_task_status_to_sent(data[i].id);
        //   console.log(error);
        // }

        // if (error.description.includes("Forbidden: user is deactivated")) {
        //   await update_user_task_notification(data[i].user_id, 0);
        //   await update_task_status_to_sent(data[i].id);
        //   console.log(error);
        // }
        console.log(error);
      }
    }



  } catch (error) {
  }
}

const interval = 60 * 1000
main();
setInterval(() => {
  main();
}, interval);
