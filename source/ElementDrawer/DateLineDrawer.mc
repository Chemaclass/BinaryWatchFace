using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class DateLineDrawer
{
    public function draw(dc as Dc) as Void
    {
        var width = dc.getWidth();

        var app = Application.getApp();

        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var date = Lang.format("$1$, $2$ $3$ $4$", [
            today.day_of_week,
            today.day,
            today.month,
            today.year
        ]);
        var justification = Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER;

        dc.setColor(app.getProperty("DateColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width/2, 20, Graphics.FONT_MEDIUM, date, justification);
    }
}
