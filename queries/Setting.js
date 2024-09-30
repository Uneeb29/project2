import {MYSQL_CONFIG} from "../config.js";
import mysql from "mysql2/promise";
const TABLE_NAME = "tg_setting";

export const get_setting = async () => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.execute(`SELECT * FROM ${TABLE_NAME} WHERE \`id\` = 1`);
    await connection.end();
    return rows[0];
  } catch (error) {
    throw error;
  }
};

export const update_setting_private_key = async (private_key = "") => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.execute(
      `UPDATE ${TABLE_NAME} SET \`private_key\` = '${private_key}' WHERE \`id\` = 1`
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_setting_nft_address = async (nft_address = "") => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.execute(
      `UPDATE ${TABLE_NAME} SET \`nft_address\` = '${nft_address}' WHERE \`id\` = 1`
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_setting_rpc_url = async (rpc_url = "") => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.execute(
      `UPDATE ${TABLE_NAME} SET \`rpc_url\` = '${rpc_url}' WHERE \`id\` = 1`
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_setting_is_testnet = async (is_testnet = 1) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.execute(
      `UPDATE ${TABLE_NAME} SET \`is_testnet\` = '${is_testnet}' WHERE \`id\` = 1`
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};
