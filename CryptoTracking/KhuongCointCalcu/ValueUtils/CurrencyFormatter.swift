import Foundation

open class CurrencyFormatterOptions: NSObject {
    var addCurrencySymbol = true
    var showPositivePrefix = false
    var showNegativePrefix = true
    var locale: Locale? = nil
    var allowTruncation = false
    override init() {}
    init(currencyCode:String) {
        locale = Locale(identifier: currencyCode)
    }
}

open class CurrencyFormatter: NSObject {

    static let shared = CurrencyFormatter()

    let formatter = NumberFormatter()
    let stringFromNumberFormatter = NumberFormatter()
    let truncatingFormatter = NumberFormatter()
    let percentFormatter = NumberFormatter()
    let numberFromStringFormatter = NumberFormatter()
    let currencies = [
        "USD": "$",
        "EUR": "€",
        "JPY": "¥",
        "GBP": "₤",
        "CAD": "$",
        "KRW": "₩",
        "CNY": "¥",
        "AUD": "$",
        "BRL": "R$",
        "IDR": "Rp",
        "MXN": "$",
        "SGD": "$",
        "CHF": "Fr."
    ]

    override init() {

        // Setup non standard formatters
        truncatingFormatter.usesSignificantDigits = true
        truncatingFormatter.maximumSignificantDigits = 5
        truncatingFormatter.minimumSignificantDigits = 0
        truncatingFormatter.maximumFractionDigits = 8
        truncatingFormatter.minimumFractionDigits = 2
        truncatingFormatter.locale = nil
        truncatingFormatter.minimumIntegerDigits = 1

        stringFromNumberFormatter.locale = Locale(identifier: "en_US")
        stringFromNumberFormatter.minimumIntegerDigits = 1
        stringFromNumberFormatter.maximumFractionDigits = 8

        percentFormatter.minimumIntegerDigits = 1
        percentFormatter.maximumFractionDigits = 2


        numberFromStringFormatter.locale = Locale(identifier: "en_US")
        numberFromStringFormatter.minimumIntegerDigits = 1
        numberFromStringFormatter.maximumFractionDigits = 8

    }

    func stringFromNumber(_ amount: Double) -> String {
        return stringFromNumberFormatter.string(from: NSNumber(value: amount))!
    }
    func stringFromNumber(amount: Double, fractionDigits:Int) -> String {
        let stringFromNumberFormatter = NumberFormatter()
        stringFromNumberFormatter.locale = Locale(identifier: "en_US")
        stringFromNumberFormatter.minimumIntegerDigits = 1
        stringFromNumberFormatter.maximumFractionDigits = fractionDigits
        stringFromNumberFormatter.numberStyle = .decimal
        return stringFromNumberFormatter.string(from: NSNumber(value: amount))!
    }

    func formatAmountString(_ amount: String, currency: String, options: CurrencyFormatterOptions?) -> String {
        return formatAmount((amount as NSString).doubleValue, currency: currency, options: options)
    }

    func formatAmount(_ amount: Double, currency: String, options: CurrencyFormatterOptions? , fractionDigits: Int = 2) -> String {

        var formatOptions = CurrencyFormatterOptions()

        if let options = options {
            formatOptions = options
        }

        let amount = amount
        let currency = currency

        if let locale = formatOptions.locale {
            formatter.locale = locale
            formatter.usesGroupingSeparator = true
        } else {
            formatter.locale = Locale(identifier: "en_US")
        }
        
        formatter.minimumIntegerDigits = 1
        formatter.maximumFractionDigits = fractionDigits
        formatter.minimumFractionDigits = fractionDigits
        
        if formatOptions.allowTruncation == true {
            return formatTruncating(amount, currency: currency, options: formatOptions)
        }

        return formatSymbolAndPrefix(amount, currency: currency, numFormatter: formatter, options: formatOptions)
    }

    func numberFromString(_ amount: String, currency: String, options: CurrencyFormatterOptions?) -> Double {
        numberFromStringFormatter.numberStyle = NumberFormatter.Style.currency
        //numberFromStringFormatter.currencySymbol = currencies[currency]
        numberFromStringFormatter.locale = Locale(identifier: "en_US")
        let number = numberFromStringFormatter.number(from: amount)
        return (number?.doubleValue)!
    }

    fileprivate func formatTruncating(_ amount: Double, currency: String, options: CurrencyFormatterOptions) -> String {

        formatter.currencySymbol = ""

        let tempOutput = formatter.string(from: NSNumber(value: amount))!
        let dotIndex = tempOutput.range(of: ".")?.lowerBound
        let currentNumberOfFractionDigits = dotIndex == nil ? 0 : (tempOutput.substring(from: dotIndex!).characters.count - 1)

        if options.allowTruncation && (currentNumberOfFractionDigits > 2) {
            return formatSymbolAndPrefix(amount, currency: currency, numFormatter: truncatingFormatter, options: options)
        }

        return formatSymbolAndPrefix(amount, currency: currency, numFormatter: formatter, options: options)
    }

    fileprivate func formatSymbolAndPrefix(_ amount: Double, currency: String, numFormatter: NumberFormatter, options: CurrencyFormatterOptions) -> String {
        var output = ""
        output = formatSymbol(amount, currency: currency, numFormatter: numFormatter, options: options)
        output = formatPrefix(amount, output: output, options: options)
        return output
    }

    fileprivate func formatSymbol(_ amount: Double, currency: String, numFormatter: NumberFormatter, options: CurrencyFormatterOptions) -> String {
        var output = ""
        if options.addCurrencySymbol {
            if let currencyCode = currencies[currency] {
                numFormatter.numberStyle = NumberFormatter.Style.currency
                numFormatter.currencySymbol = currencyCode
                output = numFormatter.string(from: NSNumber(value: amount))!
            } else {
                if currency.characters.count > 0 {
                    numFormatter.numberStyle = NumberFormatter.Style.decimal
                    output = "\(numFormatter.string(from: NSNumber(value: amount))!) \(currency)"
                } else {
                    numFormatter.numberStyle = NumberFormatter.Style.decimal
                    output = "\(numFormatter.string(from: NSNumber(value: amount))!)"
                }
            }
        } else {
            numFormatter.numberStyle = NumberFormatter.Style.decimal
            output = numFormatter.string(from: NSNumber(value: amount))!
        }
        return output
    }

    fileprivate func formatPrefix(_ amount: Double, output: String, options: CurrencyFormatterOptions) -> String {
        var formattedOutput = output
        if options.showPositivePrefix && amount > 0 {
            formattedOutput = "\(formatter.plusSign!)\(formattedOutput)"
        }
        if options.showNegativePrefix == false && amount < 0 {
            // Setting formatter.negativePrefix messes up currency symbols so just chop off first character
            formattedOutput = formattedOutput
                .substring(from: formattedOutput.characters.index(formattedOutput.startIndex, offsetBy: 1))
        }
        return formattedOutput
    }
}
extension CurrencyFormatter {
    func toPercent(fromDouble value:Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.multiplier = NSNumber(value: 1)
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
    
}
