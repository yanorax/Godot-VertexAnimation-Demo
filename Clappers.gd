extends Spatial

const MAX_COLOURS = 8
const MAX_COLUMNS = 20

onready var mm_instance = $MultiMeshInstance
onready var rows = $Rows

func _ready():
	
	var mm_rows = rows.get_child_count()
	var mm_columns = MAX_COLUMNS
	var mm_count = mm_rows * mm_columns
	
	mm_instance.multimesh.instance_count = 0 #has to be zero to make changes to multimesh
	mm_instance.multimesh.custom_data_format = MultiMesh.CUSTOM_DATA_FLOAT
	mm_instance.multimesh.instance_count = mm_count
	
	var mm_index = 0
	
	for row in rows.get_children():
		
		var row_global_transform = row.global_transform
		
		for _column in range(mm_columns):
			mm_instance.multimesh.set_instance_transform(mm_index, row_global_transform)
			row_global_transform.origin.x += 2.0
			
			var palette_pixel_size = 1.0 / float(MAX_COLOURS)
			var palette_halfpixel_size = palette_pixel_size * 0.5 #for centring the U coordinate in the fragment shader
			randomize()
			var shoe_colour = (palette_pixel_size * float(randi() % MAX_COLOURS)) + palette_halfpixel_size
			randomize()
			var pants_colour = (palette_pixel_size * float(randi() % MAX_COLOURS)) + palette_halfpixel_size
			randomize()
			var shirt_colour = (palette_pixel_size * float(randi() % MAX_COLOURS)) + palette_halfpixel_size
			randomize()
			var animation_offset = randf()
			var rand_col = Color(shoe_colour, pants_colour, shirt_colour, animation_offset)
			
			mm_instance.multimesh.set_instance_custom_data(mm_index, rand_col)
			mm_index += 1

