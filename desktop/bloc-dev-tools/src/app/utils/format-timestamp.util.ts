export function formatTimestamp(duration: number) {
  console.log(duration);
  const milliseconds: number = (duration % 1000) / 100;
  const seconds: number = (duration / 1000) % 60;
  const minutes: number = (duration / (1000 * 60)) % 60;
  const minutesStr: string = minutes < 10 ? '0' + minutes : minutes.toString();
  const secondsStr = seconds < 10 ? '0' + seconds : seconds.toString();

  return `+${minutesStr}:${secondsStr}.${milliseconds}`;
}
