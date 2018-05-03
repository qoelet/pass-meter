# pass-meter

```shell
$ pass-meter
Enter a password (or Ctrl+C to quit):
123
Meter Weak (Just AllInteger)

Enter a password (or Ctrl+C to quit):
123foo
Meter Weak (Just TooShort)

Enter a password (or Ctrl+C to quit):
123foobarbaz
Meter Weak (Just NoMixedCase)

Enter a password (or Ctrl+C to quit):
123FooBarBaz
Meter Strong Nothing
```
Inspired by [Troy Hunt's article on password indicators](https://www.troyhunt.com/password-strength-indicators-help-people-make-dumb-choices/)

Also: [NIST Guidelines](https://www.nist.gov/itl/tig/projects/special-publication-800-63)

Words list taken from: [dwyl/english-words](https://github.com/dwyl/english-words/)
