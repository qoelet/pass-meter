{-# LANGUAGE OverloadedStrings #-}

module MeterSpec where

import           Test.Hspec

import           Meter

spec :: Spec
spec =
  describe "meter" $ do
    dict <- runIO $ getDict "data/words.txt"
    let meter' = meter dict
    context "given password 'food'" $
      it "returns Weak" $
        meter' "food" `shouldBe` Meter Weak (Just TooShort)
    context "given password '12345'" $
      it "returns Weak" $
        meter' "12345" `shouldBe` Meter Weak (Just AllInteger)
    context "given password 'foobarbazqux12345'" $
      it "returns Weak" $
        meter' "foobarbazqux12345" `shouldBe` Meter Weak (Just NoMixedCase)
    context "given password 'DarkHorseMagicWand'" $
      it "returns Weak" $
        meter' "DarkHorseMagicWand" `shouldBe` Meter Weak (Just CommonWords)
    context "given a repetitive password" $
      it "returns Weak" $
        meter' "aaaaaaaaaaaaaAAAAaaaAAAAA" `shouldBe` Meter Weak (Just Repetitive)
    context "given a relatively strong password" $
      it "approves" $ do
        meter' "Tx110Wh3r3Th15B0at" `shouldBe` Meter Strong Nothing
        meter' "Cauliflow3r1SN1c3" `shouldBe` Meter Strong Nothing
