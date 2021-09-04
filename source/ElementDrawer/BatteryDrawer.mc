using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BatteryDrawer
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
        var stats = System.getSystemStats();
        var text = "";
        if (stats.charging) {
            text += "Charging|";
        }
        text += Math.round(stats.battery).format("%d")+ "%";
        var font = Graphics.FONT_SMALL;
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;

        dc.setColor(_app.getProperty("BatteryColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(_widthScreen, _heightScreen - 30, font, text, justification);
    }
}
