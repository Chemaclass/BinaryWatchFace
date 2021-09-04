using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class StepsDrawer
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
        var info = ActivityMonitor.getInfo();
        var text = "Steps:" + Math.round(info.steps).format("%d");
        var font = Graphics.FONT_SMALL;
        var justification = Graphics.TEXT_JUSTIFY_LEFT;

        dc.setColor(_app.getProperty("StepsColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(0, _heightScreen - 30, font, text, justification);
    }
}
