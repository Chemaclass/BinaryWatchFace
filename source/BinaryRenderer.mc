using Toybox.Application;
using Toybox.Lang;
using Toybox.WatchUi;

/**
 * This is a Decorator to the actual BinaryConversor. 
 * It adds zeros to the left to unify the lenght of the visual binary result.   
 */
class BinaryRenderer
{
	private var _binaryZerosLength;
	
	private var _conversor as BinaryConversor;

    function initialize(binaryZerosLength as Int) as Void
    {
        _binaryZerosLength = binaryZerosLength;
        _conversor = new BinaryConversor();
    }
    
    public function fromDecimal(n as Int) as String
    {
        return padLeftZeros(_conversor.decimalToBinary(n));
    }

    private function padLeftZeros(inputString as String) as String
    {
        if (inputString.length() >= _binaryZerosLength) {
            return inputString;
        }

        var sb = "";
        while (sb.length() < _binaryZerosLength - inputString.length()) {
            sb += "0";
        }
        sb += inputString;
    
        return sb.toString();
    }
}
