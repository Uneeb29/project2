import { Bot, Composer, InlineKeyboard, InputFile } from "grammy";
import { conversations, createConversation } from "@grammyjs/conversations";
import { isValidAddress, is_task_still_valid, now_date_timestamp, validateEmail } from "../utils/helper.js";
import { mintFreeNFT } from "../utils/on-chain.js";
import { get_users, update_user_banned_me, update_user_email, update_user_nft_rank, update_user_owner_address, update_user_task_notification, update_user_twitter } from "../queries/User.js";
import { get_task_by_id, mark_task_as_done, mark_task_as_done_with_proof, mark_task_as_done_with_proof_need_verify } from "../queries/Tasks.js";
import { get_all_zero_group } from "../queries/Groups.js";
import { get_campaign_by_id, get_campaign_num_task, get_campaign_tasks_user_step, get_campaign_tasks_users, insert_campaign_task_user, mark_campaign_task_done, mark_campaign_task_done_proof, mark_campaign_user_done } from "../queries/Campaign.js";
import { start_campaign_keyboard } from "../utils/keyboard.js";
import { campaign_task_keyboard } from "./Campaign.js";


const shill_group_id = -1001852380869
const twitter_start = 'https://twitter.com/'
const twitter_url = 'twitter.com'
const x_twitter_url = 'x.com'

/**
 * 
 * @param {string} data 
 * @returns bool
 */
const is_valid_tweet = (data) => {
  return data.includes(twitter_url) || data.includes(x_twitter_url)
}

export const callbackHandler = new Composer();

callbackHandler.use(conversations());

const emailInputHandler = async (conversation, ctx) => {
  await ctx.reply(`Please input your email address`);
  const { message } = await conversation.wait();
  const address = message?.text;
  if (typeof address === 'undefined') {
    try {
      await ctx.reply(`Please Try again !!!`);
    } catch (error) {
      console.log(error)
    }
    return;
  }

  if (validateEmail(address)) {
    await update_user_email(ctx.callbackQuery.from.id, address);
    await ctx.reply(`✅ Email address successfully updated`);
  } else {
    await ctx.reply(`❌Email not valid, Please try again !`);
    return;
  }
};

const twitterInputHandler = async (conversation, ctx) => {
  await ctx.reply(`Please input your twitter username`);
  const { message } = await conversation.wait();
  const address = message?.text;

  if (typeof address === 'undefined') {
    try {
      await ctx.reply(`Please Try again !!!`);
    } catch (error) {
      console.log(error)
    }
    return;
  }


  await update_user_twitter(ctx.callbackQuery.from.id, address);
  await ctx.reply(`✅ Twitter username successfully updated`);

};

const proofInputHandler = async (conversation, ctx) => {
  let msg_reply = 'Please input the tweet link as proof that the task has been completed!'

  if (ctx.payload.proof_type === 'twitter') {
    msg_reply = `Please input the tweet link as proof that the task has been completed!`;
  }

  else if (ctx.payload.proof_type === 'link') {
    msg_reply = `Please submit the url link as proof that the task has been completed!`;
  }

  else if (ctx.payload.proof_type === 'image') {
    msg_reply = `Please submit the image as proof that the task has been completed!`;
  }



  await ctx.reply(msg_reply);
  const user_task_id = ctx.payload.user_task_id
  const proof_type = ctx.payload.proof_type
  const { message } = await conversation.wait();
  const user_proof = message?.text;

  console.log({ message })

  if (proof_type === 'image') {
    if (message?.photo === undefined) {
      try {
        await ctx.reply(`Please Try again !!!`);
      } catch (error) {
        console.log(error)
      }
      return;
    }

    else {
      console.log(message.photo)
      try {
        // await mark_task_as_done_with_proof_need_verify(user_task_id, user_proof);
        await ctx.reply(`✅ Thanks for submitting the task.`);
      } catch (error) {
        console.log(error);
      }
    }
    return;
  }

  if (typeof user_proof === 'undefined') {
    try {
      await ctx.reply(`Please Try again !!!`);
    } catch (error) {
      console.log(error)
    }
    return;
  }



  if (proof_type === 'link') {
    if (!user_proof.startsWith('http')) {
      try {
        await ctx.reply(`Please Try again !!!`);
      } catch (error) {
        console.log(error)
      }
      return;
    }
    else {
      try {
        await mark_task_as_done_with_proof_need_verify(user_task_id, user_proof);
        await ctx.reply(`✅ Thanks for submitting the task.`);
      } catch (error) {
        console.log(error);
      }
    }
  }



  if (proof_type === 'twitter') {

    if (!is_valid_tweet(user_proof)) {
      try {
        await ctx.reply(`Not valid tweet link !`);
      } catch (error) {
        console.log(error)
      }
      return;
    }

    else {

      const list_group = await get_all_zero_group();
      try {
        await mark_task_as_done_with_proof_need_verify(user_task_id, user_proof);
        await ctx.reply(`✅ Thanks for submitting the task.`);
        if (user_proof.startsWith(twitter_start)) {
          await ctx.api.sendMessage(shill_group_id, user_proof);

          if (list_group !== null) {
            for (let i = 0; i < list_group.length; i++) {
              await ctx.api.sendMessage(list_group[i].id, user_proof);
            }
          }

        }
      } catch (error) {
        console.log(error);
        // await ctx.reply(`Error.......`);
      }
    }
  }

  else {
    if (!is_valid_tweet(user_proof)) {
      try {
        await ctx.reply(`Not valid tweet link !`);
      } catch (error) {
        console.log(error)
      }
      return;
    }

    else {

      const list_group = await get_all_zero_group();
      try {
        await mark_task_as_done_with_proof_need_verify(user_task_id, user_proof);
        await ctx.reply(`✅ Thanks for submitting the task.`);
        if (user_proof.startsWith(twitter_start)) {
          await ctx.api.sendMessage(shill_group_id, user_proof);

          if (list_group !== null) {
            for (let i = 0; i < list_group.length; i++) {
              await ctx.api.sendMessage(list_group[i].id, user_proof);
            }
          }

        }
      } catch (error) {
        console.log(error);
        // await ctx.reply(`Error.......`);
      }
    }
  }


};

const proofCampaignInputHandler = async (conversation, ctx) => {
  await ctx.reply(`Please input the tweet link as proof that the task has been completed!`);
  const user_task_id = ctx.payload.user_task_id
  const user_campaign_id = ctx.payload.user_campaign_id

  const { message } = await conversation.wait();
  const address = message?.text;

  if (typeof address === 'undefined') {
    try {
      await ctx.reply(`Please Try again !!!`);
    } catch (error) {
      console.log(error)
    }
    return;
  } else if (!is_valid_tweet(address)) {
    try {
      await ctx.reply(`Not valid tweet link !`);
    } catch (error) {
      console.log(error)
    }
    return;
  }

  else {

    const list_group = await get_all_zero_group();

    try {
      await mark_campaign_task_done_proof(user_task_id, ctx.callbackQuery.from.id, address);

      // need check if its last task
      const x_campaign_info = await get_campaign_by_id(user_campaign_id);
      const x_count_task = await get_campaign_num_task(user_campaign_id)
      const x_step_task = await get_campaign_tasks_user_step(user_campaign_id, ctx.callbackQuery.from.id)

      // make keyboard

      if (x_count_task >= x_step_task) {
        // await mark_campaign_user_done(x_campaign_info.id, ctx.callbackQuery.from.id)
        await ctx.reply(`✅ Thanks for submitting the task.`, {
          parse_mode: "HTML",
          reply_markup: start_campaign_keyboard(user_campaign_id, x_step_task)
        });
      } else {

        let return_message = `✅ Thanks for submitting the task. 

${x_campaign_info.campaign_complete_message}
`
        if (x_campaign_info.campaign_complete_image === null || x_campaign_info.campaign_complete_image === '') {
          await ctx.reply(return_message)
        } else {
          await ctx.replyWithPhoto(new InputFile({
            url: `https://arborbotadmin.arborswap.org/assets/uploads/${x_campaign_info.campaign_complete_image}`
          }), {
            caption: return_message,
          });
        }
      }

      // await ctx.reply(`✅ Thanks for submitting the task.`);


      if (address.startsWith(twitter_start)) {
        await ctx.api.sendMessage(shill_group_id, address);

        if (list_group !== null) {
          for (let i = 0; i < list_group.length; i++) {
            await ctx.api.sendMessage(list_group[i].id, address);
          }
        }

      }
    } catch (error) {
      console.log(error);
      // await ctx.reply(`Error.......`);
    }
  }


};

const walletInputHandler = async (conversation, ctx) => {
  await ctx.reply(`Please input your personal wallet address`);
  const { message } = await conversation.wait();
  const address = message?.text;
  if (typeof address === 'undefined') {
    try {
      await ctx.reply(`Please Try again !!!`);
    } catch (error) {
      console.log(error)
    }
    return;
  }
  if (isValidAddress(address)) {
    await update_user_owner_address(ctx.callbackQuery.from.id, address);
    await ctx.reply(`✅ Personal Wallet address successfully updated`);
  } else {
    await ctx.reply(`❌Wallet Address not valid, Please try again !`);
    return;
  }
};

callbackHandler.use(createConversation(emailInputHandler));
callbackHandler.use(createConversation(walletInputHandler));
callbackHandler.use(createConversation(twitterInputHandler));
callbackHandler.use(createConversation(proofInputHandler));
callbackHandler.use(createConversation(proofCampaignInputHandler));

callbackHandler.on("callback_query:data", async (ctx) => {
  // console.log({ cb: ctx.callbackQuery })
  const data = ctx.callbackQuery.data;
  const [command, payload] = data.split(" ");
  const user_ids = ctx.callbackQuery.from.id;
  const users = await get_users(user_ids);
  try {
    switch (command) {
      case "update_email":
        await ctx.conversation.enter("emailInputHandler");
        break;
      case "update_twitter":
        await ctx.conversation.enter("twitterInputHandler");
        break;
      case "update_wallet":
        await ctx.conversation.enter("walletInputHandler");
        break;

      case "mint_nft":
        const user_id = ctx.callbackQuery.from.id;

        const user = await get_users(user_id);

        if (user !== null) {
          if (user.email !== null && user.owner_address !== null && user.username !== null) {
            const rank = 1;

            const tx = await mintFreeNFT(user.generated_address, rank);
            if (tx === rank) {
              user.rank = rank;
              await update_user_nft_rank(user_id, rank);

              await ctx.reply(`<b>Mint NFT failed, You already have NFT!</b>`, {
                parse_mode: "HTML",
              });
            } else if (tx !== "") {
              await update_user_nft_rank(user_id, rank);

              await ctx.reply(`<b>Mint NFT Success!</b>`, {
                parse_mode: "HTML",
                reply_markup: new InlineKeyboard().url("View Tx", tx),
              });
            } else {
              await ctx.reply(`<b>Mint NFT Failed!</b>`, { parse_mode: "HTML" });
            }
          } else {
            await ctx.reply(`Please fill your Email Address, Personal Wallet and Telegram Username before mint free NFT`);
          }
        }

        break;
      case "toggle_task":
        const user_idxx = ctx.callbackQuery.from.id;

        const userss = await get_users(user_idxx);
        if (userss !== null) {
          const new_setting = userss.enable_task === 0 ? 1 : 0;

          try {
            await update_user_task_notification(userss.id, new_setting);
            const message = new_setting === 1 ? "<b>Task Setting Successfully Enabled</b>" : "<b>Task Setting Successfully Disabled</b>"
            await ctx.reply(message, {
              parse_mode: "HTML",
            });
          } catch (error) {
            await ctx.reply(`<b>Error</b>`, {
              parse_mode: "HTML",
            });

          }
        }
        break;

      case "complete_task":
        const user_ids = ctx.callbackQuery.from.id;

        const users = await get_users(user_ids);
        const tasks = await get_task_by_id(Number(payload))

        if (!is_task_still_valid(tasks.send_date)) {
          await ctx.reply(`<b>This task is no longer valid! </b>`, {
            parse_mode: "HTML",
          });
        }

        else if (tasks.is_completed === 1) {
          await ctx.reply(`<b>Task already completed! </b>`, {
            parse_mode: "HTML",
          });
        }

        else if (user_ids === tasks.user_id) {
          try {
            await mark_task_as_done(tasks.id);
            await ctx.reply(`✅ Thanks for submitting the task.`, {
              parse_mode: "HTML",
            });
          } catch (error) {
            await ctx.reply(`<b>Error</b>`, {
              parse_mode: "HTML",
            });

          }
        }

        else {
          await ctx.reply(`<b>Error</b>`, {
            parse_mode: "HTML",
          });
        }

        break;
      case "proof_task":
      case "proof_task_link":
      case "proof_task_twitter":
      case "proof_task_image":

        const user_idx = ctx.callbackQuery.from.id;
        const proof_type = command.split("_")[2]

        ctx.payload = {
          user_task_id: Number(payload),
          proof_type: proof_type
        };
        const usersx = await get_users(user_idx);
        const tasksx = await get_task_by_id(Number(payload))

        if (!is_task_still_valid(tasksx.send_date)) {
          await ctx.reply(`<b>This task is no longer valid! </b>`, {
            parse_mode: "HTML",
          });
        }

        else if (tasksx.is_completed === 1) {
          await ctx.reply(`<b>Task already completed! </b>`, {
            parse_mode: "HTML",
          });
        }

        else if (user_idx === tasksx.user_id) {
          await ctx.conversation.enter("proofInputHandler");
        }

        else {
          await ctx.reply(`<b>Error</b>`, {
            parse_mode: "HTML",
          });
        }

        break;

      case "campaign_task":
        const campaign_info = await get_campaign_by_id(payload);
        const count_task = await get_campaign_num_task(payload)
        const step_task = await get_campaign_tasks_user_step(payload, ctx.callbackQuery.from.id)

        if (step_task === 1) {
          if (campaign_info.campaign_start_image === null || campaign_info.campaign_start_image === '') {
            await ctx.reply(`${campaign_info.campaign_start_message}`, {
              reply_markup: start_campaign_keyboard(payload, 1)
            })
          } else {
            await ctx.replyWithPhoto(new InputFile({
              url: `https://arborbotadmin.arborswap.org/assets/uploads/${campaign_info.campaign_start_image}`
            }), {
              caption: campaign_info.campaign_start_message,
              parse_mode: "HTML",
              reply_markup: start_campaign_keyboard(payload, 1),
            });
          }
        }

        else if (step_task > count_task) {
          if (campaign_info.campaign_complete_image === null || campaign_info.campaign_complete_image === '') {
            await ctx.reply(`${campaign_info.campaign_complete_message}`)
          } else {
            await ctx.replyWithPhoto(new InputFile({
              url: `https://arborbotadmin.arborswap.org/assets/uploads/${campaign_info.campaign_complete_image}`
            }), {
              caption: campaign_info.campaign_complete_message,
            });
          }
        }

        else {
          await ctx.reply(`${campaign_info.campaign_continue_message}`, {
            reply_markup: start_campaign_keyboard(payload, step_task)
          })
        }



        break;

      case "start_campaign_task":

        const [a_campaign_id, a_campaign_order] = payload.split("_")
        console.log("HEREHERHEREHREHREHREHREHREHRERHE")
        console.log({ a_campaign_id, a_campaign_order })
        const start_campaign_task = await get_campaign_tasks_users(a_campaign_id, a_campaign_order);
        if (start_campaign_task) {
        console.log({ start_campaign_task })

        await insert_campaign_task_user(start_campaign_task.id, ctx.callbackQuery.from.id)
        const task_message = `
        Task no. ${start_campaign_task.task_order}

${start_campaign_task.task_instruction}

`
        }
        else {
          console.error('start_campaign_task is null or undefined', {
              a_campaign_id,
              a_campaign_order,
              start_campaign_task,
          });
          await ctx.reply('<b>Error: Invalid campaign task</b>', {
              parse_mode: 'HTML',
          });
      }

        const start_reply_keyboard = campaign_task_keyboard(start_campaign_task);

        // if (start_campaign_task.task_image === null || start_campaign_task.task_image === '') {
        //   await ctx.reply(task_message, {
        //     parse_mode: 'HTML',
        //     reply_markup: start_reply_keyboard
        //   })
        // } else {
        //   await ctx.replyWithPhoto(new InputFile({
        //     url: `https://arborbotadmin.arborswap.org/assets/uploads/${start_campaign_task.task_image}`
        //   }), {
        //     caption: task_message,
        //     parse_mode: 'HTML',
        //     reply_markup: start_reply_keyboard
        //   });
        // }



        break

      case "complete_campaign":

        const [x_campaign_task_id, x_campaign_id] = payload.split("_")

        await mark_campaign_task_done(x_campaign_task_id, ctx.callbackQuery.from.id);


        // need check if its last task
        const x_campaign_info = await get_campaign_by_id(x_campaign_id);
        const x_count_task = await get_campaign_num_task(x_campaign_id)
        const x_step_task = await get_campaign_tasks_user_step(x_campaign_id, ctx.callbackQuery.from.id)

        // make keyboard

        if (x_count_task >= x_step_task) {
          await ctx.reply(`✅ Thanks for submitting the task.`, {
            parse_mode: "HTML",
            reply_markup: start_campaign_keyboard(x_campaign_id, x_step_task)
          });
        } else {
          // await mark_campaign_user_done(x_campaign_info.id, ctx.callbackQuery.from.id)
          let return_message = `✅ Thanks for submitting the task. 

${x_campaign_info.campaign_complete_message}
`
          if (x_campaign_info.campaign_complete_image === null || x_campaign_info.campaign_complete_image === '') {
            await ctx.reply(return_message)
          } else {
            await ctx.replyWithPhoto(new InputFile({
              url: `https://arborbotadmin.arborswap.org/assets/uploads/${x_campaign_info.campaign_complete_image}`
            }), {
              caption: return_message,
            });
          }


        }

        break;

      case "proof_campaign":

        const [z_campaign_task_id, z_campaign_id] = payload.split("_")

        ctx.payload = {
          user_task_id: z_campaign_task_id,
          user_campaign_id: z_campaign_id
        }

        await ctx.conversation.enter("proofCampaignInputHandler");

        break

      default:
        break;
    }
  } catch (error) {
    throw error;
  }

  await ctx.answerCallbackQuery(); // remove loading animation
});
