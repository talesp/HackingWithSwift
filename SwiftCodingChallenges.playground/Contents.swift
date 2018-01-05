//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

/*:
 ## Challenge 1: Are letters Unique?

 **Difficulty**: Easy

 Write a function that accepts a String as its only parameter, and returns true if the string has only unique letters, taking letter case into account.”

 */

func challenge1(input: String) -> Bool {
/*:
 Solução naïve inicial - contagem de quantas vezes cada caracter aparece
 
 ```
 var characters: [String: Int] = [:]
 for char in input.characters {
     let c = String(char)
     char   acters[c] = (characters[c] ?? 0) + 1
 }
 for (key, value) in characters {
     if value > 1 {
         return false
     }
 }
 return true
 ```
 */
    return Set(input).count == input.count
}

assert(challenge1(input: "No duplicates") == true, "Challenge 1 failed")
assert(challenge1(input: "abcdefghijklmnopqrstuvwxyz") == true, "Challenge 1 failed")
assert(challenge1(input: "AaBbCc") == true, "Challenge 1 failed")
assert(challenge1(input: "Hello, world") == false, "Challenge 1 failed")

/*:
 ## Challenge 2: Is a string a palindrome?

 **Dificult**: Easy

 Write a function that accepts a String as its only parameter, and returns true if the string reads the same when reversed, ignoring case.

 */

func challenge2(input: String) -> Bool {

//: Essa solução não funciona com Swift 4 - strings mudou

    let lower = Array(input.lowercased())
    return lower == Array(lower.reversed())
}

assert(challenge2(input: "rotator") == true, "Challenge  failed")
assert(challenge2(input: "Rats live on no evil star") == true, "Challenge  failed")
assert(challenge2(input: "Never odd or even") == false, "Challenge  failed")
assert(challenge2(input: "Hello, world") == false, "Challenge  failed")

/*:
 ## Challenge 3: Do two strings contain the same characters?

 **Difficulty**: Easy

 Write a function that accepts two String parameters, and returns true if they contain the same characters in any order taking into account letter case.
 */

func challenge3(inputA: String, inputB: String) -> Bool {
/*:
 Solução naïve inicial
     
 ```
 var charactersA: [String: Int] = [:]
 var charactersB: [String: Int] = [:]
 
 for char in inputA.characters {
     let c = String(char)
     charactersA[c] = (charactersA[c] ?? 0) + 1
 }
 for char in inputB.characters {
     let c = String(char)
     charactersB[c] = (charactersB[c] ?? 0) + 1
 }
 return charactersA == charactersB
 ```
 */
    let array1 = Array(inputA)
    let array2 = Array(inputB)
    return array1.sorted() == array2.sorted()
}

assert(challenge3(inputA: "abca", inputB: "abca") == true, "Challenge failed")
assert(challenge3(inputA: "abc", inputB: "cab") == true, "Challenge failed")
assert(challenge3(inputA: " a1 b2", inputB: "b 1 a2") == true, "Challenge failed")
assert(challenge3(inputA: "abc", inputB: "abca") == false, "Challenge failed")
assert(challenge3(inputA: "abc", inputB: "Abc") == false, "Challenge failed")
assert(challenge3(inputA: "abc", inputB: "cbAa") == false, "Challenge failed")

/*:
 ## Challenge 4: Does one string contain another?
 
 **Difficulty**: Easy
 
 Write your own version of the contains() method on String that ignores letter case, and without using the existing contains() method.
 */

extension String {
    func fuzzyContains(_ input: String) -> Bool {
/*:
         
 Solução naïve: não funciona se tamanho de `input` mais offset do primeiro char passar tamanho da string
     
 ```
 let lowercase = self.lowercased()
 let lowercasedInput = input.lowercased()
 let inputArray = Array(lowercasedInput.characters)
 guard let first = inputArray.first,
     let index = lowercase.characters.index(of: first) else { return false }
 let lastIndex = lowercase.characters.index(index, offsetBy: lowercasedInput.characters.count)
 return lowercase.substring(with: index..<lastIndex) == lowercasedInput
 ```
*/
        return self.lowercased().range(of: input.lowercased(), options: .caseInsensitive) != nil
    }
}
assert("Hello, world".fuzzyContains("Hello") == true, "Challenge failed")
assert("Hello, world".fuzzyContains("WORLD") == true, "Challenge failed")
assert("Hello, world".fuzzyContains("good bye") == false, "Challenge failed")

/*:
 ## Challenge 5: Count the characters
 
 **Difficulty**: Easy
 
 Write a function that accepts a string, and returns how many times a specific character appears, taking case into account.
 
 **Tip**: If you can solve this without using a for-in loop, you can consider it a Tricky challenge.
 */

func challenge5(input: String, char: Character) -> Int {
    return input.reduce(0, { (result, currentChar) in
        return result + (currentChar == char ? 1 : 0)
    })
}

assert(challenge5(input: "The rain in Spain", char: "a") == 2, "Challenge failed")
assert(challenge5(input: "Mississippi", char: "i") == 4, "Challenge failed")
assert(challenge5(input: "Hacking with Swift", char: "i") == 3, "Challenge failed")

/*:
 ## Challenge 6: Remove duplicate letters from a string
 
 **Difficulty**: Easy
 
 Write a function that accepts a string as its input, and returns the same string just with duplicate letters removed.
 
 Tip: If you can solve this challenge without a for-in loop, you can consider it “tricky” rather than “easy”.
 */

func challenge6(input: String) -> String {
/*:
 Solução naïve: `NSOrderedSet` não é muito perfotmático
 
 ````
 let characters = NSOrderedSet(array: input.characters.map(String.init))
 let array = Array(characters) as! [String]
 return array.joined()
 
 ````
     
 */
    var usedChars = [Character: Bool]()
    let result = input.filter { character in
        usedChars.updateValue(true, forKey: character) == nil
    }
    return String(result)
}

assert(challenge6(input: "Mississippi") == "Misp", "Challenge failed")

/*:
 ## Challenge 7: Condense whitespace
 
 **Difficulty**: Easy
 
 Write a function that returns a string with any consecutive spaces replaced with a single space.
 
 Sample input and output
 I’ve marked spaces using “[space]” below for visual purposes:
 
 The string “a[space][space][space]b[space][space][space]c” should return “a[space]b[space]c”.
 The string “[space][space][space][space]a” should return “[space]a”.
 The string “abc” should return “abc”.
 */

func challenge7(input: String) -> String {
/*:
 Primeira solução:
     
    guard let regex = try? NSRegularExpression(pattern: "\\s+", options: .caseInsensitive) else { return input }
    let output = try? regex.stringByReplacingMatches(in: input,
                                                     options: .withTransparentBounds,
                                                     range: NSMakeRange(0, input.characters.count),
                                                     withTemplate: " ")
    return output ?? input
 */
    //: Solução one-liner
    return input.replacingOccurrences(of: " +", with: " ", options: .regularExpression, range: nil)
}
assert(challenge7(input: "a   b   c") == "a b c", "Challenge failed")
assert(challenge7(input: "   a") == " a", "Challenge failed")
assert(challenge7(input: "abc") == "abc", "Challenge failed")

/*:
 ## Challenge 8: String is rotated

 **Difficulty**: Tricky

 Write a function that accepts two strings, and returns true if one string is rotation of the other, taking letter case into account.

 Tip: A string rotation is when you take a string, remove some letters from its end, then append them to the front. For example, “swift” rotated by two characters would be “ftswi”.

 Sample input and output
 The string “abcde” and “eabcd” should return true.
 The string “abcde” and “cdeab” should return true.
 The string “abcde” and “abced” should return false; this is not a string rotation.
 */

func challenge8(original: String, rotated: String) -> Bool {
    guard original.count == rotated.count else { return false }
    for index in 0..<original.count {
        let suffix = original.suffix(index)
        let preffix = original.prefix(original.count - index)
        let internalRotated = "\(suffix)\(preffix)"
        if rotated == internalRotated {
            return true
        }
    }
    return false

/*:
uma solução mais simples:

```
     let combined = original + original
     return combined.contains(rotated)
```
 */
}

assert(challenge8(original: "abcde", rotated: "eabcd"), "Challenge failed")
assert(challenge8(original: "abcde", rotated: "cdeab"), "Challenge failed")
assert(challenge8(original: "abcde", rotated: "abced") == false, "Challenge failed")

/*:
 ##Challenge 9: Find pangrams

 **Difficulty**: Tricky

 Write a function that returns true if it is given a string that is an English pangram, ignoring letter case.

 Tip: A pangram is a string that contains every letter of the alphabet at least once.

 Sample input and output
 The string “The quick brown fox jumps over the lazy dog” should return true.
 The string “The quick brown fox jumped over the lazy dog” should return false, because it’s missing the S.
 */

func challenge9(input: String) -> Bool {
    return Set(input.lowercased().filter({ $0 >= "a" && $0 <= "z"})).count == 26
}

assert(challenge9(input: "The quick brown fox jumps over the lazy dog") == true, "Challenge failed")
assert(challenge9(input: "The quick brown fox jumped over the lazy dog") == false, "Challenge failed")

/*:
 ##Challenge 10: Vowels and consonants

 **Difficulty**: Tricky

 Given a string in English, return a tuple containing the number of vowels and consonants.

 Tip: Vowels are the letters, A, E, I, O, and U; consonants are the letters B, C, D, F, G, H, J, K, L, M, N, P, Q, R, S, T, V, W, X, Y, Z.

 Sample input and output
 The input “Swift Coding Challenges” should return 6 vowels and 15 consonants.
 The input “Mississippi” should return 4 vowels and 7 consonants.
*/

func challenge10(input: String) -> (vowels: Int, consonants: Int) {
    let vowels = "AEIOU"
    let filtered = input.uppercased().filter({ $0 >= "A" && $0 <= "Z" })
    let consonants = filtered
        .filter({ vowels.contains($0) == false })
    return (vowels: filtered.count - consonants.count, consonants: consonants.count)
}

assert(challenge10(input: "Swift Coding Challenges") == (vowels: 6, consonants: 15), "challenge failed")
assert(challenge10(input: "Mississippi") == (vowels: 4, consonants: 7), "challenge failed")
//: [Next](@next)
