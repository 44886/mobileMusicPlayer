$(function () {
    $.layer = function () {
        var height = $(window).height();
        var top = (height - 150) / 2;
        $(".content").css("marginTop", top);
        $(".right").width(parseInt($(".content").width()) - 132);
        $("#ctrl").rotate(90);
    };
    $.layer();
    $(window).resize($.layer);


    /*开始播放音乐*/
    var audio = document.getElementById("audio");
    var allTime, nowTime, imgRotate, imgRoatateAngle = 0, playing, lrc;

    /* toast*/
    $.toast = function (str) {
        $("#toast").stop(true);
        $("#toast>div").html(str);
        $("#toast").fadeIn();
        setTimeout(function () {
            $("#toast").fadeOut();
        }, 2000);
    };
    /*读取歌词*/
    $.parseLyric = function (text) {
        var lyric = text.split('\n'); //先按行分割
        var _l = lyric.length; //获取歌词行数
        var lrc = new Array(); //新建一个数组存放最后结果
        for (i = 0; i < _l; i++) {
            var d = lyric[i].match(/\[\d{2}:\d{2}((\.|\:)\d{2})\]/g);  //正则匹配播放时间
            var t = lyric[i].split(d); //以时间为分割点分割每行歌词，数组最后一个为歌词正文
            if (d != null) { //过滤掉空行等非歌词正文部分
                //换算时间，保留两位小数
                var dt = String(d).split(':');
                var _t = parseInt(dt[0].split('[')[1]) * 60 + parseInt(dt[1].split(']')[0]);
                lrc[_t] = t[1];
            }
        }
        return lrc;
    };
    $.ajax({
        url: "other/lei.lrc",
        success: function (msg) {
            lrc = $.parseLyric(msg);
            console.log(lrc);
        }
    });

    /*开始播放*/
    $.play = function () {
        playing = true;
        imgRotate = setInterval(function () {
            imgRoatateAngle += 1;
            $("#img").rotate({
                animateTo: imgRoatateAngle
            });
        }, 100);
        $(".ball").addClass("ball-play");
        $("#ctrl").text("〓");
        $.toast("开始播放");
        audio.play();
    };
    /*暂停播放*/
    $.pause = function () {
        playing = false;
        clearInterval(imgRotate);
        $(".ball").removeClass("ball-play");
        $("#ctrl").text("▲");
        $.toast("暂停播放");
        audio.pause();
    };


    setInterval(function () {
        allTime = audio.duration;
        nowTime = audio.currentTime;
        var p = (parseInt(nowTime) / parseInt(allTime)) * 100;
        $(".now").animate({"width": p + "%"});
        $(".ball").animate({"left": p + "%"});

        /*匹配歌詞*/
        if (lrc[parseInt(nowTime)] !== undefined) {
            if ($(".geci").text() != lrc[parseInt(nowTime)]) {
                $(".geci").fadeOut(200, function () {
                    $(".geci").text(lrc[parseInt(nowTime)]).fadeIn();
                });
            }
        }
        /*强制循环或者是播放完了就停止*/
        if(nowTime ==allTime){
            audio.currentTime = 1;
            $.play();
        }
    }, 1000);


    /*点击磁盘*/
    $(".img").click(function () {
        if (playing) {
            $.pause();
        } else {
            $.play();
        }
    });
    /*键盘控制*/

    $(document).keydown(function (e) {
        var k = e.keyCode;
        if (k == 32) {
            if (playing) {
                $.pause();
            } else {
                $.play();
            }
        }
    });

    /*手势控制*/
    touch.on("body", 'swipeleft', function (ev) {
        audio.currentTime -= 0.05 * allTime;
        $.toast("进度 "+parseInt((nowTime/allTime)*100)+"%");
        return false;
    });
    touch.on("body", 'swiperight', function (ev) {
        audio.currentTime += 0.05 * allTime;
        $.toast("进度 "+parseInt((nowTime/allTime)*100)+"%");
        return false;
    });
    touch.on("body", 'swipeup', function (ev) {
        if (audio.volume < 1) {
            audio.volume += 0.1;
            $.toast("音量 "+parseInt(audio.volume*100)+"%");
        } else {
            $.toast("音量已经最大");
        }

        return false;
    });
    touch.on("body", 'swipedown', function (ev) {
        if (audio.volume > 0) {
            audio.volume -= 0.1;
            $.toast("音量 "+parseInt(audio.volume*100)+"%");
        } else {
            $.toast("已经静音了");
        }
        return false;
    });

});