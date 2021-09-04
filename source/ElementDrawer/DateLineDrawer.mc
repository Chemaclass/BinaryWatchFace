using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class DateLineDrawer
{
    private var _app as Application;
    private var _widthScreen as Int;
    private var _heightScreen as Int;

    function initialize(app, widthScreen, heightScreen)
    {
        _app = app;
        _widthScreen = widthScreen;
        _heightScreen = heightScreen;        
    }

    public function draw(dc as Dc) as Void
    {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var date = Lang.format("$1$, $2$ $3$ $4$", [
            today.day_of_week,
            today.day,
            today.month,
            today.year
        ]);
        var justification = Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER;
        
        dc.setColor(_app.getProperty("DateColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(_widthScreen/2, 20, Graphics.FONT_MEDIUM, date, justification);
    }
}
