        var nowTemp = new Date();
        var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
        var soon = new Date();
        var daysToAdd = 7;

        soon.setDate(now.getDate() + daysToAdd);


        $(document).ready(function () {
            $('#dp-input').datepicker({
                format: 'YYYY-mm-dd'
            });

            /*var $departing = $('#dp-input').val();
            var $returning = $('#dp2-input').val();

            var dd = $departing.split('-')[2];
            var mm = $departing.split('-')[1];
            var y = $departing.split('-')[0];

            var $departFormatted = mm + "/" + dd + "/" + y;
            $('#dp-input').val($departFormatted);


            dd = $returning.split('-')[2];
            mm = $returning.split('-')[1];
            y = $returning.split('-')[0];

            var $returnFormatted = mm + "/" + dd + "/" + y;

            $('#dp2-input').val($returnFormatted);*/

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
