export function generateUUID() {
  const s4 = () => Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)
  return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
}

export function compare(a, b) {
  if (a.priority < b.priority) {
    return -1;
  } else if (b.priority < a.priority) {
    return 1;
  }

  return 0;
}

export default {
  generateUUID,
  compare
}
