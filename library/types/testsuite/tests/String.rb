# encoding: utf-8

# ***************************************************************************
#
# Copyright (c) 2002 - 2012 Novell, Inc.
# All Rights Reserved.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of version 2 of the GNU General Public License as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, contact Novell, Inc.
#
# To contact Novell about this file by physical or electronic mail,
# you may find current contact information at www.novell.com
#
# ***************************************************************************
module Yast
  class StringClient < Client
    def main
      Yast.include self, "testsuite.rb"
      Yast.import "String"

      DUMP("String::Quote")
      TEST(lambda { String.Quote(nil) }, [], nil)
      TEST(lambda { String.Quote("") }, [], nil)
      TEST(lambda { String.Quote("a") }, [], nil)
      TEST(lambda { String.Quote("a'b") }, [], nil)
      TEST(lambda { String.Quote("a'b'c") }, [], nil)

      DUMP("String::UnQuote")
      TEST(lambda { String.UnQuote(nil) }, [], nil)
      TEST(lambda { String.UnQuote("") }, [], nil)
      TEST(lambda { String.UnQuote("a") }, [], nil)
      TEST(lambda { String.UnQuote("a'\\''b") }, [], nil)
      TEST(lambda { String.UnQuote("a'\\''b'\\''c") }, [], nil)

      DUMP("String::FormatSize")
      TEST(lambda { String.FormatSize(nil) }, [], nil)
      TEST(lambda { String.FormatSize(0) }, [], nil)
      TEST(lambda { String.FormatSize(1) }, [], nil)
      TEST(lambda { String.FormatSize(1025) }, [], nil)
      TEST(lambda { String.FormatSize(1125) }, [], nil)
      TEST(lambda { String.FormatSize(743 * 1024) }, [], nil)
      TEST(lambda { String.FormatSize(1049000) }, [], nil)
      TEST(lambda { String.FormatSize(1074000000) }, [], nil)
      TEST(lambda { String.FormatSize(1100000000000) }, [], nil)
      TEST(lambda { String.FormatSize(1126000000000000) }, [], nil)
      TEST(lambda { String.FormatSize(1 << 10) }, [], nil)
      TEST(lambda { String.FormatSize(1 << 20) }, [], nil)
      TEST(lambda { String.FormatSize(1 << 30) }, [], nil)
      TEST(lambda { String.FormatSize(1 << 40) }, [], nil)

      DUMP("String::FormatSizeWithPrecision")
      TEST(lambda { String.FormatSizeWithPrecision(nil, nil, nil) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(0, nil, true) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(1, 2, false) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(1025, 3, false) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(1024 * 1024, 2, true) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(1049000, 2, true) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(1024 * 1024 * 1024, 2, true) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(1074000000, 3, false) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(1100000000000, 2, false) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(1126000000000000, 1, true) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(4096, 2, true) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(4096, 2, false) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(4097, 2, true) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(8589934592, 2, true) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(15, 5, false) }, [], nil)
      TEST(lambda { String.FormatSizeWithPrecision(23456767890, 3, true) }, [], nil)

      DUMP("String::CutBlanks")
      TEST(lambda { String.CutBlanks(nil) }, [], nil)
      TEST(lambda { String.CutBlanks("") }, [], nil)
      TEST(lambda { String.CutBlanks(" ") }, [], nil)

      TEST(lambda { String.CutBlanks("abc") }, [], nil)
      TEST(lambda { String.CutBlanks(" abc") }, [], nil)
      TEST(lambda { String.CutBlanks("abc ") }, [], nil)
      TEST(lambda { String.CutBlanks(" abc ") }, [], nil)
      TEST(lambda { String.CutBlanks("  abc") }, [], nil)
      TEST(lambda { String.CutBlanks("abc  ") }, [], nil)

      TEST(lambda { String.CutBlanks("ab c") }, [], nil)
      TEST(lambda { String.CutBlanks(" ab c") }, [], nil)
      TEST(lambda { String.CutBlanks("ab c ") }, [], nil)
      TEST(lambda { String.CutBlanks(" ab c ") }, [], nil)
      TEST(lambda { String.CutBlanks("  ab c") }, [], nil)
      TEST(lambda { String.CutBlanks("ab c  ") }, [], nil)
      TEST(lambda { String.CutBlanks("  ab c  ") }, [], nil)
      TEST(lambda { String.CutBlanks("ab  c") }, [], nil)

      DUMP("String::CutZeros")
      TEST(lambda { String.CutZeros(nil) }, [], nil)
      TEST(lambda { String.CutZeros("") }, [], nil)
      TEST(lambda { String.CutZeros("1") }, [], nil)
      TEST(lambda { String.CutZeros("01") }, [], nil)
      TEST(lambda { String.CutZeros("001") }, [], nil)
      TEST(lambda { String.CutZeros("0") }, [], nil)
      TEST(lambda { String.CutZeros("00") }, [], nil)

      DUMP("String::Repeat")
      TEST(lambda do
        Builtins.mergestring(["\"", String.Repeat(nil, 2), "\""], "")
      end, [], nil)
      TEST(lambda do
        Builtins.mergestring(["\"", String.Repeat(".", 8), "\""], "")
      end, [], nil)
      TEST(lambda do
        Builtins.mergestring(["\"", String.Repeat(".", -1), "\""], "")
      end, [], nil)

      DUMP("String::SuperPad")
      TEST(lambda do
        Builtins.mergestring(
          ["\"", String.SuperPad(nil, 2, nil, :left), "\""],
          ""
        )
      end, [], nil)
      TEST(lambda do
        Builtins.mergestring(
          ["\"", String.SuperPad("a", 8, ".", :left), "\""],
          ""
        )
      end, [], nil)
      TEST(lambda do
        Builtins.mergestring(
          ["\"", String.SuperPad("abc", 8, ".", :left), "\""],
          ""
        )
      end, [], nil)
      TEST(lambda do
        Builtins.mergestring(
          ["\"", String.SuperPad("a", 8, ".", :right), "\""],
          ""
        )
      end, [], nil)
      TEST(lambda do
        Builtins.mergestring(
          ["\"", String.SuperPad("abc", 8, ".", :right), "\""],
          ""
        )
      end, [], nil)

      DUMP("String::Pad")
      TEST(lambda { Builtins.mergestring(["\"", String.Pad(nil, 2), "\""], "") }, [], nil)
      TEST(lambda { Builtins.mergestring(["\"", String.Pad("", 2), "\""], "") }, [], nil)
      TEST(lambda { Builtins.mergestring(["\"", String.Pad("a", 2), "\""], "") }, [], nil)
      TEST(lambda { Builtins.mergestring(["\"", String.Pad("ab", 2), "\""], "") }, [], nil)
      TEST(lambda { Builtins.mergestring(["\"", String.Pad("abc", 2), "\""], "") }, [], nil)
      TEST(lambda { Builtins.mergestring(["\"", String.Pad("a", -1), "\""], "") }, [], nil)
      TEST(lambda { Builtins.mergestring(["\"", String.Pad("", 0), "\""], "") }, [], nil)
      TEST(lambda { Builtins.mergestring(["\"", String.Pad("a", 0), "\""], "") }, [], nil)

      DUMP("String::PadZeros")
      TEST(lambda { String.PadZeros(nil, 4) }, [], nil)
      TEST(lambda { String.PadZeros("", 4) }, [], nil)
      TEST(lambda { String.PadZeros("1", 4) }, [], nil)
      TEST(lambda { String.PadZeros("12", 4) }, [], nil)
      TEST(lambda { String.PadZeros("123", 4) }, [], nil)
      TEST(lambda { String.PadZeros("1234", 4) }, [], nil)
      TEST(lambda { String.PadZeros("12345", 4) }, [], nil)

      DUMP("String::ParseOptions")
      TEST(lambda { String.ParseOptions("a=3\tb=2", {}) }, [], nil)
      TEST(lambda { String.ParseOptions("a=3 b=2", {}) }, [], nil)
      TEST(lambda { String.ParseOptions("a=", {}) }, [], nil)

      @param = {
        "separator"         => ",",
        "unique"            => true,
        "remove_whitespace" => true
      }

      # Basic functionality
      TEST(lambda { String.ParseOptions(nil, @param) }, [{}, {}, {}], nil)
      TEST(lambda { String.ParseOptions("", @param) }, [{}, {}, {}], nil)
      TEST(lambda { String.ParseOptions("    ", @param) }, [{}, {}, {}], nil)
      TEST(lambda { String.ParseOptions(" abc , 123, var", @param) }, [
        {},
        {},
        {}
      ], nil)
      TEST(lambda { String.ParseOptions(" abc,123  ", @param) }, [{}, {}, {}], nil)
      TEST(lambda { String.ParseOptions("x,  y  ,  z", @param) }, [{}, {}, {}], nil)
      TEST(lambda { String.ParseOptions("0,\"1, 2, 3\", 4, 5 ", @param) }, [
        {},
        {},
        {}
      ], nil)
      TEST(lambda { String.ParseOptions(" ,,  ,", @param) }, [{}, {}, {}], nil)
      TEST(lambda { String.ParseOptions("\"abc\"", @param) }, [{}, {}, {}], nil)
      TEST(lambda { String.ParseOptions("\" abc \"", @param) }, [{}, {}, {}], nil)

      # multi separator
      Ops.set(@param, "separator", ",;.")
      TEST(lambda { String.ParseOptions("ab.sdf;  fwre  sdf", @param) }, [
        {},
        {},
        {}
      ], nil)

      # uniqe / multile test
      TEST(lambda { String.ParseOptions(" 1,2,1,1,5 ,", @param) }, [{}, {}, {}], nil)
      Ops.set(@param, "unique", false)
      TEST(lambda { String.ParseOptions(" 1,2,1,1,5 ,", @param) }, [{}, {}, {}], nil)

      # use space as separator
      Ops.set(@param, "separator", " ")
      TEST(lambda { String.ParseOptions(" \"\\\"\", 2", @param) }, [{}, {}, {}], nil)
      TEST(lambda { String.ParseOptions("   a   b zx ,, ,", @param) }, [
        {},
        {},
        {}
      ], nil)
      TEST(lambda { String.ParseOptions("   123\"56\"78  bzx ", @param) }, [
        {},
        {},
        {}
      ], nil)
      TEST(lambda { String.ParseOptions("   a \\\\ b ", @param) }, [{}, {}, {}], nil)
      TEST(lambda { String.ParseOptions(" \n \\\"  ", @param) }, [{}, {}, {}], nil)

      # don't remove white space
      Ops.set(@param, "remove_whitespace", false)
      Ops.set(@param, "separator", ",")
      TEST(lambda { String.ParseOptions("   a   b zx ,, ,", @param) }, [
        {},
        {},
        {}
      ], nil)


      DUMP("String::CutRegexMatch")
      TEST(lambda { String.CutRegexMatch("abc", "[0-9]+", true) }, [], nil)
      TEST(lambda { String.CutRegexMatch("abc12def345ghi678900", "[0-9]+", true) }, [], nil)
      TEST(lambda do
        String.CutRegexMatch("abc12def345ghi678900", "[0-9]+", false)
      end, [], nil)
      TEST(lambda { String.CutRegexMatch("abc12def345ghi678900", ".*", false) }, [], nil)

      DUMP("Strings::EscapeTags")
      TEST(lambda do
        String.EscapeTags("<font size='2'><b>text & another</b></font>")
      end, [], nil)
      TEST(lambda { String.EscapeTags("2 > 1") }, [], nil)

      DUMP("String::StartsWith")
      TEST(lambda { String.StartsWith("hello", "hello") }, [], nil)
      TEST(lambda { String.StartsWith("hello world", "hello") }, [], nil)
      TEST(lambda { String.StartsWith("hello hello", "hello") }, [], nil)
      TEST(lambda { String.StartsWith("hello", "hello world") }, [], nil)

      DUMP("Strings::RemoveShortcut")
      TEST(lambda { String.RemoveShortcut("Hello") }, [], nil)
      TEST(lambda { String.RemoveShortcut("He&llo") }, [], nil)
      TEST(lambda { String.RemoveShortcut("He&&llo") }, [], nil)
      TEST(lambda { String.RemoveShortcut("He&&&llo") }, [], nil)
      TEST(lambda { String.RemoveShortcut("He&&&&llo") }, [], nil)
      TEST(lambda { String.RemoveShortcut("He&&&&&llo") }, [], nil)
      TEST(lambda { String.RemoveShortcut("&Hello") }, [], nil)
      TEST(lambda { String.RemoveShortcut("&&Hello") }, [], nil)
      TEST(lambda { String.RemoveShortcut("&&&Hello") }, [], nil)
      TEST(lambda { String.RemoveShortcut("&&&&Hello") }, [], nil)
      TEST(lambda { String.RemoveShortcut("&&&&&Hello") }, [], nil)
      TEST(lambda { String.RemoveShortcut("&&He&llo") }, [], nil)

      DUMP("String::ReplaceWith")
      TEST(lambda { String.ReplaceWith("a\nb\tc d", "\n\t ", "-") }, [], nil)
      TEST(lambda do
        String.ReplaceWith(
          "this$# is an in&put text co@ntain$ing some special## ch@a$racters to remove",
          "&$\#@",
          ""
        )
      end, [], nil)

      nil
    end
  end
end

Yast::StringClient.new.main
