import './style.css'
import { getMsg } from './api.ts'

document.querySelector<HTMLDivElement>('#app')!.innerHTML = `
  <div>
    <h1>Cloud Pi Native</h1>
    <div class="card">
      <button id="btn" type="button"> Click me</button>
      <p id="msg"></p>
    </div>
  </div>
`

getMsg(document.querySelector<HTMLButtonElement>('#btn')!, document.querySelector<HTMLParagraphElement>('#msg')!)
