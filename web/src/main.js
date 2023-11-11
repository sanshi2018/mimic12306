import { createApp } from 'vue'
import App from './App.vue'
import Antd from 'ant-design-vue';
import router from './router'
import store from './store'
import 'ant-design-vue/dist/reset.css';
import * as Icons from '@ant-design/icons-vue';

const app = createApp(App);
// 初始入口配置页面
app.use(store).use(router).use(Antd).mount('#app') // id="app"的div在public/index.html中

// 将Icons中的所有图标组件注册为全局组件，应用到所有项目中
const icons = Icons;

for (const i in icons) {
    app.component(i, icons[i]);
}