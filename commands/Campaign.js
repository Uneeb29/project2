import { InlineKeyboard } from "grammy";

export const start_campaign_task_callback = (campaign_id, ctx) => {

}

export const campaign_task_callback = (task, ctx, total_task) => {



}

export const campaign_task_keyboard = (data) => {

  const keyboard = new InlineKeyboard();

  if (data.task_type === 'default') {
    keyboard.text("✅ TASK DONE", `complete_campaign ${data.id}_${data.campaign_id}`)
  }

  if (data.task_type === 'proof') {
    keyboard.text("✅ TASK DONE", `proof_campaign ${data.id}_${data.campaign_id}`)
  }

  return keyboard
}