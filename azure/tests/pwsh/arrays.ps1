# Input parameters
###################
Param (
    [parameter(Mandatory = $false)] [String[][]] $input_array
)




write-host
write-host "NORMAL ARRAY"
write-host "Array length:" $input_array.length
$length = 0..($input_array.length -1)
foreach ( $i in $length ) {
    write-host "Sub length:" $input_array[$i].length
    write-host "[$i]:" $input_array[$i]

    $sublength = 0..($input_array[$i].length -1)
    foreach ( $j in $sublength ) { 
        write-host "[$i][$j]:" $input_array[$i][$j]
    }
}


$input_array | % { “item $_” }

[String[][]]$new_array = [String[][]](("coise")) + [String[][]]$input_array

$new_array | % { “item $_” }


# write-host
# write-host
# write-host "PREPENDED ARRAY"
# #$input_array = new-object 'System.Collections.Generic.List[string[][]]'
# # [string[][]]$new_array=@(@("nothing"))
# # [string[][]]$new_array += $input_array | % { “item $_” }
# # $new_array | % { “item $_” }
# [string[][]]$new_array
# [string[][]]$new_array += @(@("nothing", "nothing more"))
# [string[][]]$new_array += , @($input_array | % { “$_” })
# $new_array | % { “item $_” }
# write-host "Array length:" $new_array.length
# $length = 0..($new_array.length -1)
# foreach ( $i in $length ) {
#     write-host "Sub length:" $new_array[$i].length
#     write-host "[$i]:" $new_array[$i]

#     $sublength = 0..($new_array[$i].length -1)
#     foreach ( $j in $sublength ) { 
#         write-host "[$i][$j]:" $new_array[$i][$j]
#     }
# }


write-host "That all folks!!"

# Tested with
# .\arrays.ps1 -input_array ('1','2','3')
# some of the combinatios in betwin
# .\arrays.ps1 -input_array @(@('1','2','3'),@('a','b','c'),@('foo','bar',"baz"))