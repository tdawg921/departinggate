        var nowTemp = new Date();
        var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
        var soon = new Date();
        var daysToAdd = 7;

        soon.setDate(now.getDate() + daysToAdd);
        var dd = now.getDate();
        var mm = now.getMonth() + 1;
        var y = now.getFullYear();

        var nowFormatted = mm + "/" + dd + "/" + y;

        $(function () {
            $('.datepicker').datepicker({
                format: 'mm/dd/yyyy'
            });
            $('#dp-input').attr("value", nowFormatted);
            //$('#dp2').attr("data-date-start-date", soon);

            dd = soon.getDate();
            mm = soon.getMonth() + 1;
            y = soon.getFullYear();

            var soonFormatted = mm + "/" + dd + "/" + y;
            $('#dp2-input').attr("value", soonFormatted);
            $('#dp-input').attr("data-date-start-date", nowFormatted);
            $('#dp2-input').attr("data-date-start-date", nowFormatted);



            var checkin = $('#dp-input').datepicker({
                onRender: function (date) {
                    return date.valueOf() < now.valueOf() ? 'disabled' : '';
                }
            }).on('changeDate', function (ev) {
                if (ev.date.valueOf() > checkout.date.valueOf()) {
                    var newDate = new Date(ev.date)
                    newDate.setDate(newDate.getDate() + 1);
                    checkout.setValue(newDate);
                }
                checkin.hide();
                $('#dp2-input')[0].focus();
            }).data('datepicker');
            var checkout = $('#dp2-input').datepicker({
                onRender: function (date) {
                    return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
                }
            }).on('changeDate', function (ev) {
                checkout.hide();
            }).data('datepicker');
        });
