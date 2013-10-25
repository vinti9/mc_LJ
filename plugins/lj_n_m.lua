-- Copyright (c) 2013, Florent Hedin, Markus Meuwly, and the University of Basel
-- All rights reserved.
-- The 3-clause BSD license is applied to this software.
-- see LICENSE.txt
-- 
-- lj_n_m.lua
--
-- Provides energy and gradient functions
-- for a modified n-m Lennard Jones potential
--
-- Formula is :
-- V = C * epsilon * [ (sigma/r)^n - (sigma/r)^m ]
-- Where n and m are integers and n>m ; C is a constant depending of both n and m
--
-- See for example : http://www.sklogwiki.org/SklogWiki/index.php/Lennard-Jones_model#n-m_Lennard-Jones_potential
--
-- at least 4 times faster when using luajit (see http://luajit.org/ )
--

-- parameters to tune for adapting the potential
-- this set is the same than the standard 12,6 potential
local c = 4
local n = 12
local m = 6

-- This function estimates the LJ n-m potential between a pair of atoms a and b
function lj_v_n_m_pair(xa, ya, za, xb, yb, zb, eps_a, eps_b, sig_a, sig_b)
    
    -- Lorentz-Berthelot rules
    local eps = math.sqrt(eps_a*eps_b)
    local sig = 0.5*(sig_a + sig_b)
    
    -- distance calculation
    local dx = xb - xa
    local dy = yb - ya
    local dz = zb - za
    local r = math.sqrt(dx*dx + dy*dy + dz*dz)
    
    -- evaluate pair potential
    local pot = c*eps*( math.pow(sig/r,n) - math.pow(sig/r,m) )
    
    return pot
    
end

