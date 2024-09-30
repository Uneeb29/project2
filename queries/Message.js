import { MYSQL_CONFIG } from "../config.js";
import mysql from "mysql2/promise";
const TABLE_NAME = "tg_message";

export const insert_message = async (data) => {
  const { chat_id, user_id, text, entities, dates } = data;
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `INSERT INTO ${TABLE_NAME} (chat_id, user_id,text,entities, dates) VALUES (?, ?, ?, ?, ?)`, [chat_id, user_id, text, JSON.stringify(
        entities
      ), dates]
    );
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows[0];
  } catch (error) {
    throw error;
  }
};
export const insert_chat = async (data) => {
  let { id, type, title, username, first_name, last_name, all_members_are_administrators } = data;

  all_members_are_administrators = all_members_are_administrators ? 1 : 0;

  username = typeof username === "undefined" ? "" : username;
  first_name = typeof first_name === "undefined" ? "" : first_name;
  last_name = typeof last_name === "undefined" ? "" : last_name;

  let sql_query = "";

  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);

    if (type === "group") {
      sql_query = `INSERT IGNORE INTO tg_chat (id, type, title, all_members_are_administrators) VALUES (?, ?, ?, ?)`;
      const [rows, fields] = await connection.query(sql_query, [id, type, title, all_members_are_administrators]);
    } else if (type === "supergroup") {
      sql_query = `INSERT IGNORE INTO tg_chat (id, type, title, all_members_are_administrators) VALUES (?, ?, ?, ?)`;
      const [rows, fields] = await connection.query(sql_query, [id, type, title, all_members_are_administrators]);

    } else if (type === "private") {
      sql_query = `INSERT IGNORE INTO tg_chat (id, type, username, first_name, last_name) VALUES (?, ?, ?, ?, ?)`;
      const [rows, fields] = await connection.query(sql_query, [id, type, username, first_name, last_name]);
    }

    await connection.end();

    return true;
  } catch (error) {
    console.log("error is")
    throw error;
  }
};
