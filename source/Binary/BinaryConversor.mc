using Toybox.Application;
using Toybox.Lang;
using Toybox.WatchUi;

class BinaryConversor
{
    public function decimalToBinary(n as Int) as String
    {
        var binaryNum = new Int[32];
        var i = 0;
        while (n > 0) {
            binaryNum[i] = n % 2;
            n = n / 2;
            i++;
        }
 
        var result = "";
        for (var j = i - 1; j >= 0; j--) {
            result += binaryNum[j];
        }
        
        return result;
    }
}
