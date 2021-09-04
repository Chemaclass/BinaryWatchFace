using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class DecimalClockDrawer
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

   
    public function draw(dc as Dc, clockTime as ClockTime) as Void
    {
        var width = _widthScreen/2 + 115;
        var font = Graphics.FONT_SMALL;
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;

        dc.setColor(_app.getProperty("DecimalClockColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, _heightScreen/2 - 45, font, clockTime.hour.format("%02d"), justification);
        dc.drawText(width, _heightScreen/2 - 15, font, clockTime.min.format("%02d"), justification);
        dc.drawText(width, _heightScreen/2 + 15, font, clockTime.sec.format("%02d"), justification);
    }
}
