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
# File:	modules/Map.ycp
# Package:	yast2
# Summary:	Map manipulation routines
# Authors:	Michal Svec <msvec@suse.cz>
# Flags:	Stable
#
# $Id$
require "yast"

module Yast
  class MapClass < Module
    def main
      textdomain "base"

      Yast.import "String"
    end

    # Return all keys from the map
    # @param [Hash] m the map
    # @return a list of all keys from the map
    def Keys(m)
      m = deep_copy(m)
      return [] if m == nil || m == {}
      Builtins.maplist(m) { |var, val| var }
    end

    # Return all values from the map
    # @param [Hash] m the map
    # @return a list of all values from the map
    def Values(m)
      m = deep_copy(m)
      return [] if m == nil || m == {}
      Builtins.maplist(m) { |var, val| val }
    end

    # Switch map keys to lower case
    # @param [Hash{String => Object}] m input map
    # @return [Hash] with keys converted to lower case
    def KeysToLower(m)
      m = deep_copy(m)
      newk = nil
      return {} if m == nil
      Builtins.mapmap(m) do |k, v|
        newk = Builtins.tolower(k)
        { newk => v }
      end
    end

    # Switch map keys to upper case
    # @param [Hash{String => Object}] m input map
    # @return [Hash] with keys converted to lower case
    def KeysToUpper(m)
      m = deep_copy(m)
      newk = nil
      return {} if m == nil
      Builtins.mapmap(m) do |k, v|
        newk = Builtins.toupper(k)
        { newk => v }
      end
    end

    # Check if a map contains all needed keys
    # @param [Hash] m map to be checked
    # @param [Array] keys needed keys
    # @return true if map kontains all keys
    def CheckKeys(m, keys)
      m = deep_copy(m)
      keys = deep_copy(keys)
      return false if m == nil || keys == nil

      ret = true
      Builtins.foreach(keys) do |k|
        if k == nil || !Builtins.haskey(m, k)
          Builtins.y2error("Missing key: %1", k)
          ret = false
        end
      end

      ret
    end

    # Convert options map $[var:val, ...] to string "var=val ..."
    # @param [Hash] m map to be converted
    # @return converted map
    def ToString(m)
      m = deep_copy(m)
      return "" if m == nil

      ret = ""
      Builtins.foreach(m) do |var, val|
        ret = Ops.add(ret, Builtins.sformat(" %1=%2", var, val))
      end
      String.CutBlanks(ret)
    end

    # Convert string "var=val ..." to map $[val:var, ...]
    # @param [String] s string to be converted
    # @return converted string
    def FromString(s)
      return {} if s == nil

      ret = {}
      Builtins.foreach(Builtins.splitstring(s, " ")) do |vals|
        val = Builtins.splitstring(vals, "=")
        if Ops.less_than(Builtins.size(val), 1) ||
            Ops.get_string(val, 0, "") == ""
          next
        end
        key = Ops.get_string(val, 0, "")
        if Ops.greater_than(Builtins.size(val), 1)
          Ops.set(ret, key, Ops.get_string(val, 1, ""))
        else
          Ops.set(ret, key, "")
        end
      end
      deep_copy(ret)
    end

    publish :function => :Keys, :type => "list (map)"
    publish :function => :Values, :type => "list (map)"
    publish :function => :KeysToLower, :type => "map (map <string, any>)"
    publish :function => :KeysToUpper, :type => "map (map <string, any>)"
    publish :function => :CheckKeys, :type => "boolean (map, list)"
    publish :function => :ToString, :type => "string (map)"
    publish :function => :FromString, :type => "map (string)"
  end

  Map = MapClass.new
  Map.main
end
