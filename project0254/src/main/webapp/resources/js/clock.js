function realTimeClock() {
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더해줍니다.
        var day = now.getDate();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();

        // 요일을 한국어로 표시
        var days = ["일", "월", "화", "수", "목", "금", "토"];
        var dayOfWeek = days[now.getDay()];

        // 시간, 분, 초를 두 자리 숫자로 표시하기 위해 10보다 작으면 앞에 0을 추가
        month = (month < 10 ? "0" : "") + month;
        day = (day < 10 ? "0" : "") + day;
        hours = (hours < 10 ? "0" : "") + hours;
        minutes = (minutes < 10 ? "0" : "") + minutes;
        seconds = (seconds < 10 ? "0" : "") + seconds;

        // 연월일시분초와 요일을 한국어로 표시
        var formattedDateTime = year + "년 " + month + "월 " + day + "일 (" + dayOfWeek + ") " + hours + "시 " + minutes + "분 " + seconds + "초";

        // 시간을 HTML 요소에 업데이트
        document.getElementById("clock").innerHTML = formattedDateTime;

        // 1초마다 realTimeClock 함수를 호출하여 시간을 업데이트
        setTimeout(realTimeClock, 1000);
      }