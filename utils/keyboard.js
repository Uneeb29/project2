import {InlineKeyboard} from "grammy";
import {get_active_campaign, get_campaign_by_id} from "../queries/Campaign.js";

export const active_campaign_keyboard = async (campaign_id = null) => {
  let active_campaigns = [];
  if (campaign_id === null) {
    active_campaigns = await get_active_campaign();
  } else {
    active_campaigns.push(await get_campaign_by_id(campaign_id));
  }
  console.log(active_campaigns)
  const keyboard = new InlineKeyboard();

  if (active_campaigns === null) {
    keyboard.text("There are no Active campaign now");

    return keyboard;
  }

  for (let i = 0; i < active_campaigns.length; i++) {
    const active_campaign = active_campaigns[i];
    keyboard.text(active_campaign.campaign_name, `campaign_task ${active_campaign.id}`);
    if (i !== active_campaigns.length - 1) {
      keyboard.row();
    }
  }
  // console.log(keyboard)
  return keyboard;
};

export const get_active_task_for_user = async (campaign_id, user_id, step) => {
  const campaign = await get_campaign_by_id(campaign_id);
  const keyboard = new InlineKeyboard();

  if (campaign === null) {
    keyboard.text("There are no Active campaign now");

    return keyboard;
  }

  for (let i = 0; i < active_campaigns.length; i++) {
    const active_campaign = active_campaigns[i];
    keyboard.text(active_campaign.campaign_name, `campaign_task ${active_campaign.id}`);
    if (i !== active_campaigns.length - 1) {
      keyboard.row();
    }
  }
  // console.log(keyboard)
  return keyboard;
};

export const start_campaign_keyboard = (campaign_id, task_order) => {
  const keyboard = new InlineKeyboard();
  let text_keyboard = "Continue Campaign";
  if (task_order === 1) {
    text_keyboard = "Start Campaign";
  }
  keyboard.text(text_keyboard, `start_campaign_task ${campaign_id}_${task_order}`);

  return keyboard;
};
