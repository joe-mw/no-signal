let bear = {
    sound: "roar",
    roar() {
        console.log(this.sound)
    }
}

bear.sound = "grunt";
let bearS = bear.roar
bearS();