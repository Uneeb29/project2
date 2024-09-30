const TESTENET_SCAN = "https://testnet.bscscan.com/";
const MAINNET_SCAN = "https://bscscan.com/";

export const createTxLink = (hash, isTesnet = true) => {
  return isTesnet ? `${TESTENET_SCAN}tx/${hash}` : `${MAINNET_SCAN}tx/${hash}`;
};

export const createAddressLink = (address, isTesnet = true) => {
  return isTesnet ? `${TESTENET_SCAN}address/${address}` : `${MAINNET_SCAN}address/${address}`;
};

export const escape_string = (s) => {
  let lookup = {
    '&': "&amp;",
    '"': "&quot;",
    '\'': "&apos;",
    '<': "&lt;",
    '>': "&gt;"
  };
  return s.replace(/[&"'<>]/g, c => lookup[c]);
}

export const makeNiceName = (users) => {
  const { first_name, last_name } = users;
  let first = first_name;
  let last = last_name;
  if (typeof last_name === "undefined" || last_name === null) {
    last = "";
  }

  if (last_name === "undefined") {
    last = "";
  }

  if (typeof first_name === "undefined" || first_name === null) {
    first = "";
  }

  const nice_name = `${first} ${last}`;
  return escape_string(nice_name);
};



export const validateEmail = (email) => {
  return String(email)
    .toLowerCase()
    .match(
      /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    );
};

export const isValidAddress = (address) => {
  return /^0x[a-fA-F0-9]{40}$/g.test(address);
};

export const now_date_timestamp = () => {
  return Math.floor(Date.now() / 1000);
}

export const ONE_DAY = 86400;

export const is_task_still_valid = (taskdate) => {

  const valid_date = now_date_timestamp() - ONE_DAY;

  return taskdate >= valid_date;

}