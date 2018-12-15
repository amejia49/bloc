export function convertMilliseconds(ms: number) {
  const minutes = Math.floor((ms % 3600000) / 60000), // 1 Minutes = 60000 Milliseconds
    seconds = Math.floor(((ms % 360000) % 60000) / 1000), // 1 Second = 1000 Milliseconds
    milliseconds = Math.floor((((ms % 360000) % 60000) % 1000) / 10); // 1 Millisecond = 1 Millisecond

  function formatValue(val: string) {
    if (parseInt(val, 10) < 10) {
      val = '0' + val;
    }
    return val;
  }

  const minutesString: string = formatValue(minutes.toString());
  const secondsString: string = formatValue(seconds.toString());
  const millisecondsString: string = formatValue(milliseconds.toString());

  return `+${minutesString}:${secondsString}.${millisecondsString}`;
}
