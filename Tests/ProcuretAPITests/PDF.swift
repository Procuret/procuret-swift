//
//  File.swift
//  
//
//  Created by Hugh on 12/4/2024.
//

import Foundation


struct ExamplePDF {
    
    static let base64: String = """
JVBERi0xLjMKJcTl8uXrp/Og0MTGCjMgMCBvYmoKPDwgL0ZpbHRlciAvRmxhdGVEZWNvZGUgL0xlbm\
d0aCAyMDcgPj4Kc3RyZWFtCngBXVCxbsJADN3zFW9MBo44d+bstbQMTCBZ6lB1ikAMpFJI/1/1QURQ\
Zene+fmd/XwjjhjBCaQalJmRJIcu8wbsF40p4nbCJ36w3k6EfgLdY+rLq+waERUMFScKyTss3NUVM/\
fsXrhl1hUXnB8O2KdrlqWWJIZYbPAmcM5S/bPRukvC6+mWRic0q2ib0HqslvTFbdUPeLNSJBJYD8oP\
tWMX/QdgA9ZmZVM74wu1nRqstEM9FSTUv3OOprrzhzl/n3HX4Bu2x4f5esc/r+ZLUAplbmRzdHJlYW\
0KZW5kb2JqCjEgMCBvYmoKPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvUmVzb3VyY2VzIDQg\
MCBSIC9Db250ZW50cyAzIDAgUiAvTWVkaWFCb3ggWzAgMCA1OTUuMjc1NiA4NDEuODg5OF0KPj4KZW\
5kb2JqCjQgMCBvYmoKPDwgL1Byb2NTZXQgWyAvUERGIC9UZXh0IF0gL0NvbG9yU3BhY2UgPDwgL0Nz\
MSA1IDAgUiA+PiAvRm9udCA8PCAvVFQxIDYgMCBSCj4+ID4+CmVuZG9iago3IDAgb2JqCjw8IC9OID\
MgL0FsdGVybmF0ZSAvRGV2aWNlUkdCIC9MZW5ndGggMjYxMiAvRmlsdGVyIC9GbGF0ZURlY29kZSA+\
PgpzdHJlYW0KeAGdlndUU9kWh8+9N73QEiIgJfQaegkg0jtIFQRRiUmAUAKGhCZ2RAVGFBEpVmRUwA\
FHhyJjRRQLg4Ji1wnyEFDGwVFEReXdjGsJ7601896a/cdZ39nnt9fZZ+9917oAUPyCBMJ0WAGANKFY\
FO7rwVwSE8vE9wIYEAEOWAHA4WZmBEf4RALU/L09mZmoSMaz9u4ugGS72yy/UCZz1v9/kSI3QyQGAA\
pF1TY8fiYX5QKUU7PFGTL/BMr0lSkyhjEyFqEJoqwi48SvbPan5iu7yZiXJuShGlnOGbw0noy7UN6a\
JeGjjAShXJgl4GejfAdlvVRJmgDl9yjT0/icTAAwFJlfzOcmoWyJMkUUGe6J8gIACJTEObxyDov5OW\
ieAHimZ+SKBIlJYqYR15hp5ejIZvrxs1P5YjErlMNN4Yh4TM/0tAyOMBeAr2+WRQElWW2ZaJHtrRzt\
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\
txWHc4azDz+ui6rq/Z39ff0TtSPGRz0eFR6XHwo911TvU1zeoN5Q2wo2SxrHjccdv/eD1Q3sTq+lQM\
6O5+AQ4ITnx4sf4H++eDDzZeYp9qukn/Z/2ttBailqh1tzWibakNml7THvf6YDTnR3OHS0/m/989Iz\
2mZqzymdLz5HOFZybOZ93fvJCxoXxi4kXhzpXdD66tOTSna6wrt7LgZevXvG5cqnbvfv8VZerZ645X\
Tt9nX297Yb9jdYeu56WX+x+aem172296XCz/ZbjrY6+BX3n+l37L972un3ljv+dGwOLBvruLr57/17\
cPel93v3RB6kPXj/Mejj9aP1j7OOiJwpPKp6qP6391fjXZqm99Oyg12DPs4hnj4a4Qy//lfmvT8MFz\
6nPK0a0RupHrUfPjPmM3Xqx9MXwy4yX0+OFvyn+tveV0auffnf7vWdiycTwa9HrmT9K3qi+OfrW9m3\
nZOjk03dp76anit6rvj/2gf2h+2P0x5Hp7E/4T5WfjT93fAn88ngmbWbm3/eE8/sKZW5kc3RyZWFtC\
mVuZG9iago1IDAgb2JqClsgL0lDQ0Jhc2VkIDcgMCBSIF0KZW5kb2JqCjIgMCBvYmoKPDwgL1R5cGU\
gL1BhZ2VzIC9NZWRpYUJveCBbMCAwIDU5NS4yNzU2IDg0MS44ODk4XSAvQ291bnQgMSAvS2lkcyBbI\
DEgMCBSIF0KPj4KZW5kb2JqCjggMCBvYmoKPDwgL1R5cGUgL0NhdGFsb2cgL1BhZ2VzIDIgMCBSID4\
+CmVuZG9iago2IDAgb2JqCjw8IC9UeXBlIC9Gb250IC9TdWJ0eXBlIC9UcnVlVHlwZSAvQmFzZUZvb\
nQgL0FBQUFBQisuU0ZOUy1SZWd1bGFyX3dkdGhfb3BzejExMDAwMF9HUkFEX3dnaHQyQkMwMDAwCi9\
Gb250RGVzY3JpcHRvciA5IDAgUiAvRW5jb2RpbmcgL01hY1JvbWFuRW5jb2RpbmcgL0ZpcnN0Q2hhc\
iAzMiAvTGFzdENoYXIKMTE2IC9XaWR0aHMgWyAyNTggMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCA\
wIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMAowIDAgMCAwIDAgMCAwIDc0OCAwIDU5OCAwIDAgM\
CAwIDAgMCAwIDAgMCA2NzQgMCAwIDAgNjYwIDAgMCAwIDAgMCAwIDAgMCAwCjAgMCAwIDAgMCAwIDA\
gNjAxIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgNTY2IDQxMyBdID4+CmVuZG9iago5IDAgb2JqC\
jw8IC9UeXBlIC9Gb250RGVzY3JpcHRvciAvRm9udE5hbWUgL0FBQUFBQisuU0ZOUy1SZWd1bGFyX3d\
kdGhfb3BzejExMDAwMF9HUkFEX3dnaHQyQkMwMDAwCi9GbGFncyAzMiAvRm9udEJCb3ggWy00MDIgL\
TI3NSAyNDY2IDk1N10gL0l0YWxpY0FuZ2xlIDAgL0FzY2VudCA5NjcgL0Rlc2NlbnQKLTIxMSAvQ2F\
wSGVpZ2h0IDcwNSAvU3RlbVYgODggL1hIZWlnaHQgNTM4IC9TdGVtSCA3OSAvQXZnV2lkdGggNTgwI\
C9NYXhXaWR0aAoyNDkzIC9Gb250RmlsZTIgMTAgMCBSID4+CmVuZG9iagoxMCAwIG9iago8PCAvTGV\
uZ3RoMSAxOTMyIC9MZW5ndGggMTA5MSAvRmlsdGVyIC9GbGF0ZURlY29kZSA+PgpzdHJlYW0KeAGlV\
VtslFUQ/v5/d1mKEGrrJQYwfcAYUkGLWiFRlNouReViqfUCdVvbtUvo0tJuaamNF6CJl0IUNCHxQgK\
JmlKtTdSQtiSGB2kbjAZ8sJQYQB5QxFuCQbr7f37n7LZa7IPG2ZwzZ74zM2dmzpx/4w1NEWTgefiQW\
RWrrIclp03scE3tlqdTslsK+PujkcrqlIyEeH5UQEp27hCfG43FW9LyY0auratK77v3Sb4mVtmS9o+\
TknM2VsYi4qJgoabi+rrGuBURzBQ3Pv8fOTLPwGJMsW6MNJEMojH7aGlfeObdF+GbavdPjXTEzOLUy\
Ku5icHk0eze4PsSfXDttrUJ9nurgezfEoOJoexe42UCZchTtassAqPo9g+gO1CtUYx1/i81XkS5b4X\
iMp5SltMV48eSc/DIP3xNcPwfBBOtbxJ9fxoLTLI3EUrVbSI2JgWRKpbuTb8OdOGik+m0u7PcJ5VLt\
ZcVfCv4js4P4irMRDauB5Y6kxOqg4uASwPqg3/FvSwFcUTjDw1Z4XKaG9ngV8ouunUTHYH9isXGIR3\
HFN7GMy6g212Eb5wF2CtIxArvGOclB4QAJ7ANfaiyG+BehtiaWuOAE8L36o0zzhK8Z7DRMl+P4dzNW\
7mBHmuYy10CHBOHv0JxZPy9Gug2J7gPAslPxLcBiVXGXtEAP8tMiM3V5uFPyv5a3GA8CB/PI7VMVzj\
k9GMPzuI5aYj4Amcz6umVOQ3YitfSaB2f9XZyvTndO+aYygGt+BZvKJvXxZ8xAK+2cxvblUk7LZZco\
XruF+5gnTL6UevgXxm5M4xHRzUY1Xs3XDqdmnQ/lJ6x4jl/oz+CXFmZbRO23TDL8cX49VgNTe5mbEE\
PmlGIGXC9X5jk7xzku/yMPdzJw1IxdC9iCGEZNuAeK7+U1Km+drPmVl7HMCuYzXRtVI9feU5bS/AUN\
umrM01al3meX/CEtQ5hO8qxGRVoR5H1cYhtfJuv4ANpLheyVvd+CS/bvQbP48MkVxGMK9NyZZqrTHW\
XJtP0dY2vJkld+Y/VIF0Wtxg71IDmoyxiLzdxF5fzCPt5JoVhPlZiIUoU5HRZz7Qp7GY+69nMPO5Ia\
xXpoa7HQZTqyVriV+ziADv5Jn+i551WwNNU3uO2IE9gnwrpyGsTVuvh3Kyi5+AWzBF2E/Jxo3HBPh7\
nqBZ+PK7GetRinYxwj4rwIbfzAH/gMC/wc36tBjrJIZ42OijA7bIBE9zHjexS0ljMhHshUGrfaKoIt\
ha2DdK94K5VzzyEWTI8zxGe5ac8ZN19J2SO+nhYvEyI6TfgI5p/qqkIYFiHJy1WhAdc8+3Tf5CjvvB\
MV87V2zuormgc+8Z7Q2ix2ldOernwqRTzFP5dKmOZTdlBluI3NAV36qYNFeQuWBNauWZ+SaSmqbayI\
dxcHY+G6+obW/PybhOFl5UsLQw310TjCwvuNwD+BKRHivUKZW5kc3RyZWFtCmVuZG9iagoxMSAwIG9\
iago8PCAvVGl0bGUgKFRlc3QgUERGKSAvUHJvZHVjZXIgKG1hY09TIFZlcnNpb24gMTQuNC4xIFwoQ\
nVpbGQgMjNFMjI0XCkgUXVhcnR6IFBERkNvbnRleHQpCi9BdXRob3IgKEh1Z2gpIC9DcmVhdG9yICh\
Ob3RlcykgL0NyZWF0aW9uRGF0ZSAoRDoyMDI0MDQxMjA2NTQxNVowMCcwMCcpIC9Nb2REYXRlCihEO\
jIwMjQwNDEyMDY1NDE1WjAwJzAwJykgPj4KZW5kb2JqCnhyZWYKMCAxMgowMDAwMDAwMDAwIDY1NTM\
1IGYgCjAwMDAwMDAzMDEgMDAwMDAgbiAKMDAwMDAwMzI1OSAwMDAwMCBuIAowMDAwMDAwMDIyIDAwM\
DAwIG4gCjAwMDAwMDA0MTUgMDAwMDAgbiAKMDAwMDAwMzIyNCAwMDAwMCBuIAowMDAwMDAzNDAxIDA\
wMDAwIG4gCjAwMDAwMDA1MTIgMDAwMDAgbiAKMDAwMDAwMzM1MiAwMDAwMCBuIAowMDAwMDAzNzk0I\
DAwMDAwIG4gCjAwMDAwMDQwNzkgMDAwMDAgbiAKMDAwMDAwNTI1OCAwMDAwMCBuIAp0cmFpbGVyCjw\
8IC9TaXplIDEyIC9Sb290IDggMCBSIC9JbmZvIDExIDAgUiAvSUQgWyA8YjA3YWRjN2ZmOWJhMTU5Z\
mI5NmE4NTZmMmU0MGM5MzE+CjxiMDdhZGM3ZmY5YmExNTlmYjk2YTg1NmYyZTQwYzkzMT4gXSA+Pgp\
zdGFydHhyZWYKNTQ3MwolJUVPRgo=
"""
    
    static var data: Data {
        return Self.base64.data(using: .utf8)!
    }
    
}