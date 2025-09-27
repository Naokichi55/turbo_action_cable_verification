// Import all the channels to be used by Action Cable
//AI講師に確認し記述内容を変更するために以下をコメントアウト。
import "./comments_channel"
const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

