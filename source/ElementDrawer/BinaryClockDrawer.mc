using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BinaryClockDrawer
{
    private var _app as Application;
    private var _widthScreen as Int;
    private var _heightScreen as Int;
    
    private var _binaryRenderer as BinaryRenderer;

    function initialize(app, widthScreen, heightScreen)
    {
        _app = app;
        _widthScreen = widthScreen;
        _heightScreen = heightScreen;

        _binaryRenderer = new BinaryRenderer(6);       
    }

   
    public function draw(dc as Dc, clockTime as ClockTime) as Void
    {
        var width = _widthScreen/2;
        var font = Graphics.FONT_LARGE * 2;
        var justification = Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER;

        dc.setColor(_app.getProperty("BinaryClockColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, _heightScreen/2 - 55, font, _binaryRenderer.fromDecimal(clockTime.hour), justification);
        dc.drawText(width, _heightScreen/2, font, _binaryRenderer.fromDecimal(clockTime.min), justification);
        dc.drawText(width, _heightScreen/32 * 25, font, _binaryRenderer.fromDecimal(clockTime.sec), justification);
    }
}
