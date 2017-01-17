=begin

    opengl.rb

    Arquivo com a definição das funções do OpenGL, muito bonitas por sinal
    Antes que venham me encaminhar para um psicólogo, não, eu não digitei
    tudo isso. Foi um script.

=end

#==============================================================================
# Kernel
#------------------------------------------------------------------------------
# Módulo base, tudo que é definido aqui é definido em todo lugar
#==============================================================================
module Kernel
    extend DLLImport
    include DL
    #---------------------------------------------------------------------------
    # Constantes
    #
    # Valores do OpenGL, você vai usar eles o tempo todo (acaba na linha 704)
    #---------------------------------------------------------------------------
    GL_FALSE = 0x0
    GL_TRUE = 0x1
    GL_BYTE = 0x1400
    GL_UNSIGNED_BYTE = 0x1401
    GL_SHORT = 0x1402
    GL_UNSIGNED_SHORT = 0x1403
    GL_INT = 0x1404
    GL_UNSIGNED_INT = 0x1405
    GL_FLOAT = 0x1406
    GL_DOUBLE = 0x140A
    GL_2_BYTES = 0x1407
    GL_3_BYTES = 0x1408
    GL_4_BYTES = 0x1409
    GL_POINTS = 0x0000
    GL_LINES = 0x0001
    GL_LINE_LOOP = 0x0002
    GL_LINE_STRIP = 0x0003
    GL_TRIANGLES = 0x0004
    GL_TRIANGLE_STRIP = 0x0005
    GL_TRIANGLE_FAN = 0x0006
    GL_QUADS = 0x0007
    GL_QUAD_STRIP = 0x0008
    GL_POLYGON = 0x0009
    GL_VERTEX_ARRAY = 0x8074
    GL_NORMAL_ARRAY = 0x8075
    GL_COLOR_ARRAY = 0x8076
    GL_INDEX_ARRAY = 0x8077
    GL_TEXTURE_COORD_ARRAY = 0x8078
    GL_EDGE_FLAG_ARRAY = 0x8079
    GL_VERTEX_ARRAY_SIZE = 0x807A
    GL_VERTEX_ARRAY_TYPE = 0x807B
    GL_VERTEX_ARRAY_STRIDE = 0x807C
    GL_NORMAL_ARRAY_TYPE = 0x807E
    GL_NORMAL_ARRAY_STRIDE = 0x807F
    GL_COLOR_ARRAY_SIZE = 0x8081
    GL_COLOR_ARRAY_TYPE = 0x8082
    GL_COLOR_ARRAY_STRIDE = 0x8083
    GL_INDEX_ARRAY_TYPE = 0x8085
    GL_INDEX_ARRAY_STRIDE = 0x8086
    GL_TEXTURE_COORD_ARRAY_SIZE = 0x8088
    GL_TEXTURE_COORD_ARRAY_TYPE = 0x8089
    GL_TEXTURE_COORD_ARRAY_STRIDE = 0x808A
    GL_EDGE_FLAG_ARRAY_STRIDE = 0x808C
    GL_VERTEX_ARRAY_POINTER = 0x808E
    GL_NORMAL_ARRAY_POINTER = 0x808F
    GL_COLOR_ARRAY_POINTER = 0x8090
    GL_INDEX_ARRAY_POINTER = 0x8091
    GL_TEXTURE_COORD_ARRAY_POINTER = 0x8092
    GL_EDGE_FLAG_ARRAY_POINTER = 0x8093
    GL_V2F = 0x2A20
    GL_V3F = 0x2A21
    GL_C4UB_V2F = 0x2A22
    GL_C4UB_V3F = 0x2A23
    GL_C3F_V3F = 0x2A24
    GL_N3F_V3F = 0x2A25
    GL_C4F_N3F_V3F = 0x2A26
    GL_T2F_V3F = 0x2A27
    GL_T4F_V4F = 0x2A28
    GL_T2F_C4UB_V3F = 0x2A29
    GL_T2F_C3F_V3F = 0x2A2A
    GL_T2F_N3F_V3F = 0x2A2B
    GL_T2F_C4F_N3F_V3F = 0x2A2C
    GL_T4F_C4F_N3F_V4F = 0x2A2D
    GL_MATRIX_MODE = 0x0BA0
    GL_MODELVIEW = 0x1700
    GL_PROJECTION = 0x1701
    GL_TEXTURE = 0x1702
    GL_POINT_SMOOTH = 0x0B10
    GL_POINT_SIZE = 0x0B11
    GL_POINT_SIZE_GRANULARITY = 0x0B13
    GL_POINT_SIZE_RANGE = 0x0B12
    GL_LINE_SMOOTH = 0x0B20
    GL_LINE_STIPPLE = 0x0B24
    GL_LINE_STIPPLE_PATTERN = 0x0B25
    GL_LINE_STIPPLE_REPEAT = 0x0B26
    GL_LINE_WIDTH = 0x0B21
    GL_LINE_WIDTH_GRANULARITY = 0x0B23
    GL_LINE_WIDTH_RANGE = 0x0B22
    GL_POINT = 0x1B00
    GL_LINE = 0x1B01
    GL_FILL = 0x1B02
    GL_CW = 0x0900
    GL_CCW = 0x0901
    GL_FRONT = 0x0404
    GL_BACK = 0x0405
    GL_POLYGON_MODE = 0x0B40
    GL_POLYGON_SMOOTH = 0x0B41
    GL_POLYGON_STIPPLE = 0x0B42
    GL_EDGE_FLAG = 0x0B43
    GL_CULL_FACE = 0x0B44
    GL_CULL_FACE_MODE = 0x0B45
    GL_FRONT_FACE = 0x0B46
    GL_POLYGON_OFFSET_FACTOR = 0x8038
    GL_POLYGON_OFFSET_UNITS = 0x2A00
    GL_POLYGON_OFFSET_POINT = 0x2A01
    GL_POLYGON_OFFSET_LINE = 0x2A02
    GL_POLYGON_OFFSET_FILL = 0x8037
    GL_COMPILE = 0x1300
    GL_COMPILE_AND_EXECUTE = 0x1301
    GL_LIST_BASE = 0x0B32
    GL_LIST_INDEX = 0x0B33
    GL_LIST_MODE = 0x0B30
    GL_NEVER = 0x0200
    GL_LESS = 0x0201
    GL_EQUAL = 0x0202
    GL_LEQUAL = 0x0203
    GL_GREATER = 0x0204
    GL_NOTEQUAL = 0x0205
    GL_GEQUAL = 0x0206
    GL_ALWAYS = 0x0207
    GL_DEPTH_TEST = 0x0B71
    GL_DEPTH_BITS = 0x0D56
    GL_DEPTH_CLEAR_VALUE = 0x0B73
    GL_DEPTH_FUNC = 0x0B74
    GL_DEPTH_RANGE = 0x0B70
    GL_DEPTH_WRITEMASK = 0x0B72
    GL_DEPTH_COMPONENT = 0x1902
    GL_LIGHTING = 0x0B50
    GL_LIGHT0 = 0x4000
    GL_LIGHT1 = 0x4001
    GL_LIGHT2 = 0x4002
    GL_LIGHT3 = 0x4003
    GL_LIGHT4 = 0x4004
    GL_LIGHT5 = 0x4005
    GL_LIGHT6 = 0x4006
    GL_LIGHT7 = 0x4007
    GL_SPOT_EXPONENT = 0x1205
    GL_SPOT_CUTOFF = 0x1206
    GL_CONSTANT_ATTENUATION = 0x1207
    GL_LINEAR_ATTENUATION = 0x1208
    GL_QUADRATIC_ATTENUATION = 0x1209
    GL_AMBIENT = 0x1200
    GL_DIFFUSE = 0x1201
    GL_SPECULAR = 0x1202
    GL_SHININESS = 0x1601
    GL_EMISSION = 0x1600
    GL_POSITION = 0x1203
    GL_SPOT_DIRECTION = 0x1204
    GL_AMBIENT_AND_DIFFUSE = 0x1602
    GL_COLOR_INDEXES = 0x1603
    GL_LIGHT_MODEL_TWO_SIDE = 0x0B52
    GL_LIGHT_MODEL_LOCAL_VIEWER = 0x0B51
    GL_LIGHT_MODEL_AMBIENT = 0x0B53
    GL_FRONT_AND_BACK = 0x0408
    GL_SHADE_MODEL = 0x0B54
    GL_FLAT = 0x1D00
    GL_SMOOTH = 0x1D01
    GL_COLOR_MATERIAL = 0x0B57
    GL_COLOR_MATERIAL_FACE = 0x0B55
    GL_COLOR_MATERIAL_PARAMETER = 0x0B56
    GL_NORMALIZE = 0x0BA1
    GL_CLIP_PLANE0 = 0x3000
    GL_CLIP_PLANE1 = 0x3001
    GL_CLIP_PLANE2 = 0x3002
    GL_CLIP_PLANE3 = 0x3003
    GL_CLIP_PLANE4 = 0x3004
    GL_CLIP_PLANE5 = 0x3005
    GL_ACCUM_RED_BITS = 0x0D58
    GL_ACCUM_GREEN_BITS = 0x0D59
    GL_ACCUM_BLUE_BITS = 0x0D5A
    GL_ACCUM_ALPHA_BITS = 0x0D5B
    GL_ACCUM_CLEAR_VALUE = 0x0B80
    GL_ACCUM = 0x0100
    GL_ADD = 0x0104
    GL_LOAD = 0x0101
    GL_MULT = 0x0103
    GL_RETURN = 0x0102
    GL_ALPHA_TEST = 0x0BC0
    GL_ALPHA_TEST_REF = 0x0BC2
    GL_ALPHA_TEST_FUNC = 0x0BC1
    GL_BLEND = 0x0BE2
    GL_BLEND_SRC = 0x0BE1
    GL_BLEND_DST = 0x0BE0
    GL_ZERO = 0x0
    GL_ONE = 0x1
    GL_SRC_COLOR = 0x0300
    GL_ONE_MINUS_SRC_COLOR = 0x0301
    GL_SRC_ALPHA = 0x0302
    GL_ONE_MINUS_SRC_ALPHA = 0x0303
    GL_DST_ALPHA = 0x0304
    GL_ONE_MINUS_DST_ALPHA = 0x0305
    GL_DST_COLOR = 0x0306
    GL_ONE_MINUS_DST_COLOR = 0x0307
    GL_SRC_ALPHA_SATURATE = 0x0308
    GL_CONSTANT_COLOR = 0x8001
    GL_ONE_MINUS_CONSTANT_COLOR = 0x8002
    GL_CONSTANT_ALPHA = 0x8003
    GL_ONE_MINUS_CONSTANT_ALPHA = 0x8004
    GL_FEEDBACK = 0x1C01
    GL_RENDER = 0x1C00
    GL_SELECT = 0x1C02
    GL_2D = 0x0600
    GL_3D = 0x0601
    GL_3D_COLOR = 0x0602
    GL_3D_COLOR_TEXTURE = 0x0603
    GL_4D_COLOR_TEXTURE = 0x0604
    GL_POINT_TOKEN = 0x0701
    GL_LINE_TOKEN = 0x0702
    GL_LINE_RESET_TOKEN = 0x0707
    GL_POLYGON_TOKEN = 0x0703
    GL_BITMAP_TOKEN = 0x0704
    GL_DRAW_PIXEL_TOKEN = 0x0705
    GL_COPY_PIXEL_TOKEN = 0x0706
    GL_PASS_THROUGH_TOKEN = 0x0700
    GL_FEEDBACK_BUFFER_POINTER = 0x0DF0
    GL_FEEDBACK_BUFFER_SIZE = 0x0DF1
    GL_FEEDBACK_BUFFER_TYPE = 0x0DF2
    GL_SELECTION_BUFFER_POINTER = 0x0DF3
    GL_SELECTION_BUFFER_SIZE = 0x0DF4
    GL_FOG = 0x0B60
    GL_FOG_MODE = 0x0B65
    GL_FOG_DENSITY = 0x0B62
    GL_FOG_COLOR = 0x0B66
    GL_FOG_INDEX = 0x0B61
    GL_FOG_START = 0x0B63
    GL_FOG_END = 0x0B64
    GL_LINEAR = 0x2601
    GL_EXP = 0x0800
    GL_EXP2 = 0x0801
    GL_LOGIC_OP = 0x0BF1
    GL_INDEX_LOGIC_OP = 0x0BF1
    GL_COLOR_LOGIC_OP = 0x0BF2
    GL_LOGIC_OP_MODE = 0x0BF0
    GL_CLEAR = 0x1500
    GL_SET = 0x150F
    GL_COPY = 0x1503
    GL_COPY_INVERTED = 0x150C
    GL_NOOP = 0x1505
    GL_INVERT = 0x150A
    GL_AND = 0x1501
    GL_NAND = 0x150E
    GL_OR = 0x1507
    GL_NOR = 0x1508
    GL_XOR = 0x1506
    GL_EQUIV = 0x1509
    GL_AND_REVERSE = 0x1502
    GL_AND_INVERTED = 0x1504
    GL_OR_REVERSE = 0x150B
    GL_OR_INVERTED = 0x150D
    GL_STENCIL_TEST = 0x0B90
    GL_STENCIL_WRITEMASK = 0x0B98
    GL_STENCIL_BITS = 0x0D57
    GL_STENCIL_FUNC = 0x0B92
    GL_STENCIL_VALUE_MASK = 0x0B93
    GL_STENCIL_REF = 0x0B97
    GL_STENCIL_FAIL = 0x0B94
    GL_STENCIL_PASS_DEPTH_PASS = 0x0B96
    GL_STENCIL_PASS_DEPTH_FAIL = 0x0B95
    GL_STENCIL_CLEAR_VALUE = 0x0B91
    GL_STENCIL_INDEX = 0x1901
    GL_KEEP = 0x1E00
    GL_REPLACE = 0x1E01
    GL_INCR = 0x1E02
    GL_DECR = 0x1E03
    GL_NONE = 0x0
    GL_LEFT = 0x0406
    GL_RIGHT = 0x0407
    GL_FRONT_LEFT = 0x0400
    GL_FRONT_RIGHT = 0x0401
    GL_BACK_LEFT = 0x0402
    GL_BACK_RIGHT = 0x0403
    GL_AUX0 = 0x0409
    GL_AUX1 = 0x040A
    GL_AUX2 = 0x040B
    GL_AUX3 = 0x040C
    GL_COLOR_INDEX = 0x1900
    GL_RED = 0x1903
    GL_GREEN = 0x1904
    GL_BLUE = 0x1905
    GL_ALPHA = 0x1906
    GL_LUMINANCE = 0x1909
    GL_LUMINANCE_ALPHA = 0x190A
    GL_ALPHA_BITS = 0x0D55
    GL_RED_BITS = 0x0D52
    GL_GREEN_BITS = 0x0D53
    GL_BLUE_BITS = 0x0D54
    GL_INDEX_BITS = 0x0D51
    GL_SUBPIXEL_BITS = 0x0D50
    GL_AUX_BUFFERS = 0x0C00
    GL_READ_BUFFER = 0x0C02
    GL_DRAW_BUFFER = 0x0C01
    GL_DOUBLEBUFFER = 0x0C32
    GL_STEREO = 0x0C33
    GL_BITMAP = 0x1A00
    GL_COLOR = 0x1800
    GL_DEPTH = 0x1801
    GL_STENCIL = 0x1802
    GL_DITHER = 0x0BD0
    GL_RGB = 0x1907
    GL_RGBA = 0x1908
    GL_MAX_LIST_NESTING = 0x0B31
    GL_MAX_ATTRIB_STACK_DEPTH = 0x0D35
    GL_MAX_MODELVIEW_STACK_DEPTH = 0x0D36
    GL_MAX_NAME_STACK_DEPTH = 0x0D37
    GL_MAX_PROJECTION_STACK_DEPTH = 0x0D38
    GL_MAX_TEXTURE_STACK_DEPTH = 0x0D39
    GL_MAX_EVAL_ORDER = 0x0D30
    GL_MAX_LIGHTS = 0x0D31
    GL_MAX_CLIP_PLANES = 0x0D32
    GL_MAX_TEXTURE_SIZE = 0x0D33
    GL_MAX_PIXEL_MAP_TABLE = 0x0D34
    GL_MAX_VIEWPORT_DIMS = 0x0D3A
    GL_MAX_CLIENT_ATTRIB_STACK_DEPTH = 0x0D3B
    GL_ATTRIB_STACK_DEPTH = 0x0BB0
    GL_CLIENT_ATTRIB_STACK_DEPTH = 0x0BB1
    GL_COLOR_CLEAR_VALUE = 0x0C22
    GL_COLOR_WRITEMASK = 0x0C23
    GL_CURRENT_INDEX = 0x0B01
    GL_CURRENT_COLOR = 0x0B00
    GL_CURRENT_NORMAL = 0x0B02
    GL_CURRENT_RASTER_COLOR = 0x0B04
    GL_CURRENT_RASTER_DISTANCE = 0x0B09
    GL_CURRENT_RASTER_INDEX = 0x0B05
    GL_CURRENT_RASTER_POSITION = 0x0B07
    GL_CURRENT_RASTER_TEXTURE_COORDS = 0x0B06
    GL_CURRENT_RASTER_POSITION_VALID = 0x0B08
    GL_CURRENT_TEXTURE_COORDS = 0x0B03
    GL_INDEX_CLEAR_VALUE = 0x0C20
    GL_INDEX_MODE = 0x0C30
    GL_INDEX_WRITEMASK = 0x0C21
    GL_MODELVIEW_MATRIX = 0x0BA6
    GL_MODELVIEW_STACK_DEPTH = 0x0BA3
    GL_NAME_STACK_DEPTH = 0x0D70
    GL_PROJECTION_MATRIX = 0x0BA7
    GL_PROJECTION_STACK_DEPTH = 0x0BA4
    GL_RENDER_MODE = 0x0C40
    GL_RGBA_MODE = 0x0C31
    GL_TEXTURE_MATRIX = 0x0BA8
    GL_TEXTURE_STACK_DEPTH = 0x0BA5
    GL_VIEWPORT = 0x0BA2
    GL_AUTO_NORMAL = 0x0D80
    GL_MAP1_COLOR_4 = 0x0D90
    GL_MAP1_GRID_DOMAIN = 0x0DD0
    GL_MAP1_GRID_SEGMENTS = 0x0DD1
    GL_MAP1_INDEX = 0x0D91
    GL_MAP1_NORMAL = 0x0D92
    GL_MAP1_TEXTURE_COORD_1 = 0x0D93
    GL_MAP1_TEXTURE_COORD_2 = 0x0D94
    GL_MAP1_TEXTURE_COORD_3 = 0x0D95
    GL_MAP1_TEXTURE_COORD_4 = 0x0D96
    GL_MAP1_VERTEX_3 = 0x0D97
    GL_MAP1_VERTEX_4 = 0x0D98
    GL_MAP2_COLOR_4 = 0x0DB0
    GL_MAP2_GRID_DOMAIN = 0x0DD2
    GL_MAP2_GRID_SEGMENTS = 0x0DD3
    GL_MAP2_INDEX = 0x0DB1
    GL_MAP2_NORMAL = 0x0DB2
    GL_MAP2_TEXTURE_COORD_1 = 0x0DB3
    GL_MAP2_TEXTURE_COORD_2 = 0x0DB4
    GL_MAP2_TEXTURE_COORD_3 = 0x0DB5
    GL_MAP2_TEXTURE_COORD_4 = 0x0DB6
    GL_MAP2_VERTEX_3 = 0x0DB7
    GL_MAP2_VERTEX_4 = 0x0DB8
    GL_COEFF = 0x0A00
    GL_DOMAIN = 0x0A02
    GL_ORDER = 0x0A01
    GL_FOG_HINT = 0x0C54
    GL_LINE_SMOOTH_HINT = 0x0C52
    GL_PERSPECTIVE_CORRECTION_HINT = 0x0C50
    GL_POINT_SMOOTH_HINT = 0x0C51
    GL_POLYGON_SMOOTH_HINT = 0x0C53
    GL_DONT_CARE = 0x1100
    GL_FASTEST = 0x1101
    GL_NICEST = 0x1102
    GL_SCISSOR_TEST = 0x0C11
    GL_SCISSOR_BOX = 0x0C10
    GL_MAP_COLOR = 0x0D10
    GL_MAP_STENCIL = 0x0D11
    GL_INDEX_SHIFT = 0x0D12
    GL_INDEX_OFFSET = 0x0D13
    GL_RED_SCALE = 0x0D14
    GL_RED_BIAS = 0x0D15
    GL_GREEN_SCALE = 0x0D18
    GL_GREEN_BIAS = 0x0D19
    GL_BLUE_SCALE = 0x0D1A
    GL_BLUE_BIAS = 0x0D1B
    GL_ALPHA_SCALE = 0x0D1C
    GL_ALPHA_BIAS = 0x0D1D
    GL_DEPTH_SCALE = 0x0D1E
    GL_DEPTH_BIAS = 0x0D1F
    GL_PIXEL_MAP_S_TO_S_SIZE = 0x0CB1
    GL_PIXEL_MAP_I_TO_I_SIZE = 0x0CB0
    GL_PIXEL_MAP_I_TO_R_SIZE = 0x0CB2
    GL_PIXEL_MAP_I_TO_G_SIZE = 0x0CB3
    GL_PIXEL_MAP_I_TO_B_SIZE = 0x0CB4
    GL_PIXEL_MAP_I_TO_A_SIZE = 0x0CB5
    GL_PIXEL_MAP_R_TO_R_SIZE = 0x0CB6
    GL_PIXEL_MAP_G_TO_G_SIZE = 0x0CB7
    GL_PIXEL_MAP_B_TO_B_SIZE = 0x0CB8
    GL_PIXEL_MAP_A_TO_A_SIZE = 0x0CB9
    GL_PIXEL_MAP_S_TO_S = 0x0C71
    GL_PIXEL_MAP_I_TO_I = 0x0C70
    GL_PIXEL_MAP_I_TO_R = 0x0C72
    GL_PIXEL_MAP_I_TO_G = 0x0C73
    GL_PIXEL_MAP_I_TO_B = 0x0C74
    GL_PIXEL_MAP_I_TO_A = 0x0C75
    GL_PIXEL_MAP_R_TO_R = 0x0C76
    GL_PIXEL_MAP_G_TO_G = 0x0C77
    GL_PIXEL_MAP_B_TO_B = 0x0C78
    GL_PIXEL_MAP_A_TO_A = 0x0C79
    GL_PACK_ALIGNMENT = 0x0D05
    GL_PACK_LSB_FIRST = 0x0D01
    GL_PACK_ROW_LENGTH = 0x0D02
    GL_PACK_SKIP_PIXELS = 0x0D04
    GL_PACK_SKIP_ROWS = 0x0D03
    GL_PACK_SWAP_BYTES = 0x0D00
    GL_UNPACK_ALIGNMENT = 0x0CF5
    GL_UNPACK_LSB_FIRST = 0x0CF1
    GL_UNPACK_ROW_LENGTH = 0x0CF2
    GL_UNPACK_SKIP_PIXELS = 0x0CF4
    GL_UNPACK_SKIP_ROWS = 0x0CF3
    GL_UNPACK_SWAP_BYTES = 0x0CF0
    GL_ZOOM_X = 0x0D16
    GL_ZOOM_Y = 0x0D17
    GL_TEXTURE_ENV = 0x2300
    GL_TEXTURE_ENV_MODE = 0x2200
    GL_TEXTURE_1D = 0x0DE0
    GL_TEXTURE_2D = 0x0DE1
    GL_TEXTURE_WRAP_S = 0x2802
    GL_TEXTURE_WRAP_T = 0x2803
    GL_TEXTURE_MAG_FILTER = 0x2800
    GL_TEXTURE_MIN_FILTER = 0x2801
    GL_TEXTURE_ENV_COLOR = 0x2201
    GL_TEXTURE_GEN_S = 0x0C60
    GL_TEXTURE_GEN_T = 0x0C61
    GL_TEXTURE_GEN_MODE = 0x2500
    GL_TEXTURE_BORDER_COLOR = 0x1004
    GL_TEXTURE_WIDTH = 0x1000
    GL_TEXTURE_HEIGHT = 0x1001
    GL_TEXTURE_BORDER = 0x1005
    GL_TEXTURE_COMPONENTS = 0x1003
    GL_TEXTURE_RED_SIZE = 0x805C
    GL_TEXTURE_GREEN_SIZE = 0x805D
    GL_TEXTURE_BLUE_SIZE = 0x805E
    GL_TEXTURE_ALPHA_SIZE = 0x805F
    GL_TEXTURE_LUMINANCE_SIZE = 0x8060
    GL_TEXTURE_INTENSITY_SIZE = 0x8061
    GL_NEAREST_MIPMAP_NEAREST = 0x2700
    GL_NEAREST_MIPMAP_LINEAR = 0x2702
    GL_LINEAR_MIPMAP_NEAREST = 0x2701
    GL_LINEAR_MIPMAP_LINEAR = 0x2703
    GL_OBJECT_LINEAR = 0x2401
    GL_OBJECT_PLANE = 0x2501
    GL_EYE_LINEAR = 0x2400
    GL_EYE_PLANE = 0x2502
    GL_SPHERE_MAP = 0x2402
    GL_DECAL = 0x2101
    GL_MODULATE = 0x2100
    GL_NEAREST = 0x2600
    GL_REPEAT = 0x2901
    GL_CLAMP = 0x2900
    GL_S = 0x2000
    GL_T = 0x2001
    GL_R = 0x2002
    GL_Q = 0x2003
    GL_TEXTURE_GEN_R = 0x0C62
    GL_TEXTURE_GEN_Q = 0x0C63
    GL_VENDOR = 0x1F00
    GL_RENDERER = 0x1F01
    GL_VERSION = 0x1F02
    GL_EXTENSIONS = 0x1F03
    GL_NO_ERROR = 0x0
    GL_INVALID_VALUE = 0x0501
    GL_INVALID_ENUM = 0x0500
    GL_INVALID_OPERATION = 0x0502
    GL_STACK_OVERFLOW = 0x0503
    GL_STACK_UNDERFLOW = 0x0504
    GL_OUT_OF_MEMORY = 0x0505
    GL_CURRENT_BIT = 0x00000001
    GL_POINT_BIT = 0x00000002
    GL_LINE_BIT = 0x00000004
    GL_POLYGON_BIT = 0x00000008
    GL_POLYGON_STIPPLE_BIT = 0x00000010
    GL_PIXEL_MODE_BIT = 0x00000020
    GL_LIGHTING_BIT = 0x00000040
    GL_FOG_BIT = 0x00000080
    GL_DEPTH_BUFFER_BIT = 0x00000100
    GL_ACCUM_BUFFER_BIT = 0x00000200
    GL_STENCIL_BUFFER_BIT = 0x00000400
    GL_VIEWPORT_BIT = 0x00000800
    GL_TRANSFORM_BIT = 0x00001000
    GL_ENABLE_BIT = 0x00002000
    GL_COLOR_BUFFER_BIT = 0x00004000
    GL_HINT_BIT = 0x00008000
    GL_EVAL_BIT = 0x00010000
    GL_LIST_BIT = 0x00020000
    GL_TEXTURE_BIT = 0x00040000
    GL_SCISSOR_BIT = 0x00080000
    GL_ALL_ATTRIB_BITS = 0x000FFFFF
    GL_PROXY_TEXTURE_1D = 0x8063
    GL_PROXY_TEXTURE_2D = 0x8064
    GL_TEXTURE_PRIORITY = 0x8066
    GL_TEXTURE_RESIDENT = 0x8067
    GL_TEXTURE_BINDING_1D = 0x8068
    GL_TEXTURE_BINDING_2D = 0x8069
    GL_TEXTURE_INTERNAL_FORMAT = 0x1003
    GL_ALPHA4 = 0x803B
    GL_ALPHA8 = 0x803C
    GL_ALPHA12 = 0x803D
    GL_ALPHA16 = 0x803E
    GL_LUMINANCE4 = 0x803F
    GL_LUMINANCE8 = 0x8040
    GL_LUMINANCE12 = 0x8041
    GL_LUMINANCE16 = 0x8042
    GL_LUMINANCE4_ALPHA4 = 0x8043
    GL_LUMINANCE6_ALPHA2 = 0x8044
    GL_LUMINANCE8_ALPHA8 = 0x8045
    GL_LUMINANCE12_ALPHA4 = 0x8046
    GL_LUMINANCE12_ALPHA12 = 0x8047
    GL_LUMINANCE16_ALPHA16 = 0x8048
    GL_INTENSITY = 0x8049
    GL_INTENSITY4 = 0x804A
    GL_INTENSITY8 = 0x804B
    GL_INTENSITY12 = 0x804C
    GL_INTENSITY16 = 0x804D
    GL_R3_G3_B2 = 0x2A10
    GL_RGB4 = 0x804F
    GL_RGB5 = 0x8050
    GL_RGB8 = 0x8051
    GL_RGB10 = 0x8052
    GL_RGB12 = 0x8053
    GL_RGB16 = 0x8054
    GL_RGBA2 = 0x8055
    GL_RGBA4 = 0x8056
    GL_RGB5_A1 = 0x8057
    GL_RGBA8 = 0x8058
    GL_RGB10_A2 = 0x8059
    GL_RGBA12 = 0x805A
    GL_RGBA16 = 0x805B
    GL_CLIENT_PIXEL_STORE_BIT = 0x00000001
    GL_CLIENT_VERTEX_ARRAY_BIT = 0x00000002
    GL_ALL_CLIENT_ATTRIB_BITS = 0xFFFFFFFF
    GL_CLIENT_ALL_ATTRIB_BITS = 0xFFFFFFFF
    GLU_FALSE = 0
    GLU_TRUE = 1
    GLU_VERSION_1_1 = 1
    GLU_VERSION_1_2 = 1
    GLU_VERSION = 100800
    GLU_EXTENSIONS = 100801
    GLU_INVALID_ENUM = 100900
    GLU_INVALID_VALUE = 100901
    GLU_OUT_OF_MEMORY = 100902
    GLU_INVALID_OPERATION = 100904
    GLU_OUTLINE_POLYGON = 100240
    GLU_OUTLINE_PATCH = 100241
    GLU_NURBS_ERROR1 = 100251
    GLU_NURBS_ERROR2 = 100252
    GLU_NURBS_ERROR3 = 100253
    GLU_NURBS_ERROR4 = 100254
    GLU_NURBS_ERROR5 = 100255
    GLU_NURBS_ERROR6 = 100256
    GLU_NURBS_ERROR7 = 100257
    GLU_NURBS_ERROR8 = 100258
    GLU_NURBS_ERROR9 = 100259
    GLU_NURBS_ERROR10 = 100260
    GLU_NURBS_ERROR11 = 100261
    GLU_NURBS_ERROR12 = 100262
    GLU_NURBS_ERROR13 = 100263
    GLU_NURBS_ERROR14 = 100264
    GLU_NURBS_ERROR15 = 100265
    GLU_NURBS_ERROR16 = 100266
    GLU_NURBS_ERROR17 = 100267
    GLU_NURBS_ERROR18 = 100268
    GLU_NURBS_ERROR19 = 100269
    GLU_NURBS_ERROR20 = 100270
    GLU_NURBS_ERROR21 = 100271
    GLU_NURBS_ERROR22 = 100272
    GLU_NURBS_ERROR23 = 100273
    GLU_NURBS_ERROR24 = 100274
    GLU_NURBS_ERROR25 = 100275
    GLU_NURBS_ERROR26 = 100276
    GLU_NURBS_ERROR27 = 100277
    GLU_NURBS_ERROR28 = 100278
    GLU_NURBS_ERROR29 = 100279
    GLU_NURBS_ERROR30 = 100280
    GLU_NURBS_ERROR31 = 100281
    GLU_NURBS_ERROR32 = 100282
    GLU_NURBS_ERROR33 = 100283
    GLU_NURBS_ERROR34 = 100284
    GLU_NURBS_ERROR35 = 100285
    GLU_NURBS_ERROR36 = 100286
    GLU_NURBS_ERROR37 = 100287
    GLU_AUTO_LOAD_MATRIX = 100200
    GLU_CULLING = 100201
    GLU_SAMPLING_TOLERANCE = 100203
    GLU_DISPLAY_MODE = 100204
    GLU_PARAMETRIC_TOLERANCE = 100202
    GLU_SAMPLING_METHOD = 100205
    GLU_U_STEP = 100206
    GLU_V_STEP = 100207
    GLU_PATH_LENGTH = 100215
    GLU_PARAMETRIC_ERROR = 100216
    GLU_DOMAIN_DISTANCE = 100217
    GLU_MAP1_TRIM_2 = 100210
    GLU_MAP1_TRIM_3 = 100211
    GLU_POINT = 100010
    GLU_LINE = 100011
    GLU_FILL = 100012
    GLU_SILHOUETTE = 100013
    GLU_ERROR = 100103
    GLU_SMOOTH = 100000
    GLU_FLAT = 100001
    GLU_NONE = 100002
    GLU_OUTSIDE = 100020
    GLU_INSIDE = 100021
    GLU_TESS_BEGIN = 100100
    GLU_BEGIN = 100100
    GLU_TESS_VERTEX = 100101
    GLU_VERTEX = 100101
    GLU_TESS_END = 100102
    GLU_END = 100102
    GLU_TESS_ERROR = 100103
    GLU_TESS_EDGE_FLAG = 100104
    GLU_EDGE_FLAG = 100104
    GLU_TESS_COMBINE = 100105
    GLU_TESS_BEGIN_DATA = 100106
    GLU_TESS_VERTEX_DATA = 100107
    GLU_TESS_END_DATA = 100108
    GLU_TESS_ERROR_DATA = 100109
    GLU_TESS_EDGE_FLAG_DATA = 100110
    GLU_TESS_COMBINE_DATA = 100111
    GLU_CW = 100120
    GLU_CCW = 100121
    GLU_INTERIOR = 100122
    GLU_EXTERIOR = 100123
    GLU_UNKNOWN = 100124
    GLU_TESS_WINDING_RULE = 100140
    GLU_TESS_BOUNDARY_ONLY = 100141
    GLU_TESS_TOLERANCE = 100142
    GLU_TESS_ERROR1 = 100151
    GLU_TESS_ERROR2 = 100152
    GLU_TESS_ERROR3 = 100153
    GLU_TESS_ERROR4 = 100154
    GLU_TESS_ERROR5 = 100155
    GLU_TESS_ERROR6 = 100156
    GLU_TESS_ERROR7 = 100157
    GLU_TESS_ERROR8 = 100158
    GLU_TESS_MISSING_BEGIN_POLYGON = 100151
    GLU_TESS_MISSING_BEGIN_CONTOUR = 100152
    GLU_TESS_MISSING_END_POLYGON = 100153
    GLU_TESS_MISSING_END_CONTOUR = 100154
    GLU_TESS_COORD_TOO_LARGE = 100155
    GLU_TESS_NEED_COMBINE_CALLBACK = 100156
    GLU_TESS_WINDING_ODD = 100130
    GLU_TESS_WINDING_NONZERO = 100131
    GLU_TESS_WINDING_POSITIVE = 100132
    GLU_TESS_WINDING_NEGATIVE = 100133
    GLU_TESS_WINDING_ABS_GEQ_TWO = 100134
    GLU_INCOMPATIBLE_GL_VERSION = 100903
    WGL_FONT_LINES = 0
    WGL_FONT_POLYGONS = 1
    WGL_SWAP_MAIN_PLANE = 1
    WGL_SWAP_OVERLAY1 = 2
    WGL_SWAP_OVERLAY2 = 4
    WGL_SWAP_OVERLAY3 = 8
    WGL_SWAP_OVERLAY4 = 16
    WGL_SWAP_OVERLAY5 = 32
    WGL_SWAP_OVERLAY6 = 64
    WGL_SWAP_OVERLAY7 = 128
    WGL_SWAP_OVERLAY8 = 256
    WGL_SWAP_OVERLAY9 = 512
    WGL_SWAP_OVERLAY10 = 1024
    WGL_SWAP_OVERLAY11 = 2048
    WGL_SWAP_OVERLAY12 = 4096
    WGL_SWAP_OVERLAY13 = 8192
    WGL_SWAP_OVERLAY14 = 16384
    WGL_SWAP_OVERLAY15 = 32768
    WGL_SWAP_UNDERLAY1 = 65536
    WGL_SWAP_UNDERLAY2 = 0x20000
    WGL_SWAP_UNDERLAY3 = 0x40000
    WGL_SWAP_UNDERLAY4 = 0x80000
    WGL_SWAP_UNDERLAY5 = 0x100000
    WGL_SWAP_UNDERLAY6 = 0x200000
    WGL_SWAP_UNDERLAY7 = 0x400000
    WGL_SWAP_UNDERLAY8 = 0x800000
    WGL_SWAP_UNDERLAY9 = 0x1000000
    WGL_SWAP_UNDERLAY10 = 0x2000000
    WGL_SWAP_UNDERLAY11 = 0x4000000
    WGL_SWAP_UNDERLAY12 = 0x8000000
    WGL_SWAP_UNDERLAY13 = 0x10000000
    WGL_SWAP_UNDERLAY14 = 0x20000000
    WGL_SWAP_UNDERLAY15 = 0x40000000

    #---------------------------------------------------------------------------
    # Funções
    #
    # Métodos usados para desenhar coisas na tela, isso inclui algumas funções
    # de manipulação de handle de janelas, funções da GDI32 (só porque o OpenGL
    # do Windows precisa de algumas...) e, lógico, funções do OpenGL
    #
    # Nota.: As funções que recebem floats como parâmetro PRECISAM RECEBER
    # FLOATS, passar Integers para essas funções não dá certo porque
    # aparentemente o módulo DL do Ruby não sabe lidar com números de ponto
    # flutuante, então precisei fazer umas macumbas que só funcionam quando você
    # passa um float EXPLICITAMENTE para a função. Retorno de floats funciona
    # como esperado.
    #---------------------------------------------------------------------------

	# WGL, faz a união do OpenGL com as janelas do windows
    # Também tem umas funções legais para desenho de texto
    typedef :int, :BOOL
    typedef :long, :HGLRC
    typedef :long, :HDC
	typedef :long, :HWND
    typedef :long, :PROC

    PIXELFORMATDESCRIPTOR = CStruct.create({
        nSize: 2,
		nVersion: 2,
		dwFlags: 4,
		iPixelType: 1,
		cColorBits: 1,
		cRedBits: 1,
		cRedShift: 1,
		cGreenBits: 1,
		cGreenShift: 1,
		cBlueBits: 1,
		cBlueShift: 1,
		cAlphaBits: 1,
		cAlphaShift: 1,
		cAccumBits: 1,
		cAccumRedBits: 1,
		cAccumGreenBits: 1,
		cAccumBlueBits: 1,
		cAccumAlphaBits: 1,
		cDepthBits: 1,
		cStencilBits: 1,
		cAuxBuffers: 1,
		iLayerType: 1,
		bReserved: 1,
		dwLayerMask: 4,
		dwVisibleMask: 4,
		dwDamageMask: 4
    })
	
	with_dll('opengl32') do
		import :wglGetProcAddress, :pointer
		import :wglCopyContext, :BOOL 
		import :wglCreateContext, :HGLRC
		import :wglCreateLayerContext, :HGLRC
		import :wglDeleteContext, :BOOL
		import :wglDescribeLayerPlane, :BOOL
		import :wglGetCurrentContext, :HGLRC
		import :wglGetCurrentDC, :HDC
		import :wglGetLayerPaletteEntries, :int
		import :wglMakeCurrent, :BOOL
		import :wglRealizeLayerPalette, :BOOL
		import :wglSetLayerPaletteEntries, :int
		import :wglShareLists, :BOOL
		import :wglSwapLayerBuffers, :BOOL
		import :wglUseFontBitmapsA, :BOOL
		import :wglUseFontBitmapsW, :BOOL
		import :wglUseFontOutlinesA, :BOOL
		import :wglUseFontOutlinesW, :BOOL
	end

    # User32, para manipular a interface de janelas do windows
	RECT = CStruct.create({
		left: SIZEOF_LONG,
		top: SIZEOF_LONG,
		right: SIZEOF_LONG,
		bottom: SIZEOF_LONG
	})
	
    with_dll('user32') do
        import :GetActiveWindow, :HWND
        import :GetDC, :HDC
		import :GetWindowRect, :BOOL
		import :AdjustWindowRectEx, :BOOL
		import :MoveWindow, :BOOL
		import :GetWindowLong, :long
    end

    # GDI (o mínimo possível, tudo que puder é pego do WGL no lugar)
    with_dll('gdi32') do
        import :SwapBuffers, :void
        import :ChoosePixelFormat, :int
        import :SetPixelFormat, :BOOL
    end
end
	
#==========================================================================
# Graphics
#--------------------------------------------------------------------------
# Módulo responsável por desenhar tudo na tela
# Essa é só a inicialização necessária pra pegar as funções do OpenGL 1.2
# para cima, o resto está no arquivo graphics.rb
#==========================================================================
module Graphics
	#----------------------------------------------------------------------
	# Variáveis estáticas
	#----------------------------------------------------------------------
	@@hwnd = GetActiveWindow()
	@@hdc = GetDC(@@hwnd)
	
	pfd = PIXELFORMATDESCRIPTOR.new
	pfd[:nSize] = PIXELFORMATDESCRIPTOR.size
	pfd[:nVersion] = 1
	pfd[:dwFlags] = 1 | 4 | 32
	pfd[:dwLayerMask] = 0
	pfd[:iPixelType] = 0
	pfd[:cColorBits] = 32
	pfd[:cDepthBits] = 24
	pfd[:cAccumBits] = 0
	pfd[:cStencilBits] = 0

	pixelformat = ChoosePixelFormat(@@hdc, pfd.cptr)
	if pixelformat.zero?
		msgbox("Couldn't find any compatible pixel format, aborting")
		exit
	end

	if SetPixelFormat(@@hdc, pixelformat, pfd.cptr).zero?
		msgbox("Failed to set pixel format, aborting")
		exit
	end
	
	# Contexto do OpenGL
	@@hglrc = wglCreateContext(@@hdc)
	wglMakeCurrent(@@hdc, @@hglrc)
end

#==============================================================================
# Kernel
#==============================================================================
module Kernel
	#==========================================================================
    # OpenGL
	#==========================================================================
	typedef :int, :GLboolean
    typedef :int, :GLuint
    typedef :int, :GLint
    typedef :char, :GLbyte
	
    with_dll('opengl32') do
		#----------------------------------------------------------------------
		# Importa uma função do OpenGL
		#----------------------------------------------------------------------
		def gl_import fname, ret
			types = DLLImport.class_variable_get("@@__types")
			imported = DLLImport.class_variable_get("@@__imported_functions")
			
			fname = fname.to_s.to_sym

			unless imported[fname]
				p = wglGetProcAddress(fname.to_s.cptr)
				
				return import(fname, ret) if p.zero?
				
				func = DL::CFunc.new p, types[ret], fname.to_s
				imported[fname] = func
			end
			
			define_method(fname) do |*args|
				args.size.times do |i|
					if args[i].is_a? Float
						args[i] = [args[i]].pack('g').unpack('H16').first.to_i(16)
					end
				end

				return imported[fname].call args
			end
		end
		
		#
		# OpenGL 1.1
		#
		gl_import :glClearIndex, :void
		gl_import :glClearColor, :void
		gl_import :glClear, :void
		gl_import :glIndexMask, :void
		gl_import :glColorMask, :void
		gl_import :glAlphaFunc, :void
		gl_import :glBlendFunc, :void
		gl_import :glLogicOp, :void
		gl_import :glCullFace, :void
		gl_import :glFrontFace, :void
		gl_import :glPointSize, :void
		gl_import :glLineWidth, :void
		gl_import :glLineStipple, :void
		gl_import :glPolygonMode, :void
		gl_import :glPolygonOffset, :void
		gl_import :glPolygonStipple, :void
		gl_import :glGetPolygonStipple, :void
		gl_import :glEdgeFlag, :void
		gl_import :glEdgeFlagv, :void
		gl_import :glScissor, :void
		gl_import :glClipPlane, :void
		gl_import :glGetClipPlane, :void
		gl_import :glDrawBuffer, :void
		gl_import :glReadBuffer, :void
		gl_import :glEnable, :void
		gl_import :glDisable, :void
		gl_import :glIsEnabled, :GLboolean
		gl_import :glEnableClientState, :void
		gl_import :glDisableClientState, :void
		gl_import :glGetBooleanv, :void
		gl_import :glGetDoublev, :void
		gl_import :glGetFloatv, :void
		gl_import :glGetIntegerv, :void
		gl_import :glPushAttrib, :void
		gl_import :glPopAttrib, :void
		gl_import :glPushClientAttrib, :void
		gl_import :glPopClientAttrib, :void
		gl_import :glRenderMode, :GLint
		gl_import :glGetError, :GLenum
		gl_import :glGetString, :GLubyte
		gl_import :glFinish, :void
		gl_import :glFlush, :void
		gl_import :glHint, :void
		gl_import :glClearDepth, :void
		gl_import :glDepthFunc, :void
		gl_import :glDepthMask, :void
		gl_import :glDepthRange, :void
		gl_import :glClearAccum, :void
		gl_import :glAccum, :void
		gl_import :glMatrixMode, :void
		gl_import :glOrtho, :void
		gl_import :glFrustum, :void
		gl_import :glViewport, :void
		gl_import :glPushMatrix, :void
		gl_import :glPopMatrix, :void
		gl_import :glLoadIdentity, :void
		gl_import :glLoadMatrixd, :void
		gl_import :glLoadMatrixf, :void
		gl_import :glMultMatrixd, :void
		gl_import :glMultMatrixf, :void
		gl_import :glRotated, :void
		gl_import :glRotatef, :void
		gl_import :glScaled, :void
		gl_import :glScalef, :void
		gl_import :glTranslated, :void
		gl_import :glTranslatef, :void
		gl_import :glIsList, :GLboolean
		gl_import :glDeleteLists, :void
		gl_import :glGenLists, :GLuint
		gl_import :glNewList, :void
		gl_import :glEndList, :void
		gl_import :glCallList, :void
		gl_import :glCallLists, :void
		gl_import :glListBase, :void
		gl_import :glBegin, :void
		gl_import :glEnd, :void
		gl_import :glVertex2d, :void
		gl_import :glVertex2f, :void
		gl_import :glVertex2i, :void
		gl_import :glVertex2s, :void
		gl_import :glVertex3d, :void
		gl_import :glVertex3f, :void
		gl_import :glVertex3i, :void
		gl_import :glVertex3s, :void
		gl_import :glVertex4d, :void
		gl_import :glVertex4f, :void
		gl_import :glVertex4i, :void
		gl_import :glVertex4s, :void
		gl_import :glVertex2dv, :void
		gl_import :glVertex2fv, :void
		gl_import :glVertex2iv, :void
		gl_import :glVertex2sv, :void
		gl_import :glVertex3dv, :void
		gl_import :glVertex3fv, :void
		gl_import :glVertex3iv, :void
		gl_import :glVertex3sv, :void
		gl_import :glVertex4dv, :void
		gl_import :glVertex4fv, :void
		gl_import :glVertex4iv, :void
		gl_import :glVertex4sv, :void
		gl_import :glNormal3b, :void
		gl_import :glNormal3d, :void
		gl_import :glNormal3f, :void
		gl_import :glNormal3i, :void
		gl_import :glNormal3s, :void
		gl_import :glNormal3bv, :void
		gl_import :glNormal3dv, :void
		gl_import :glNormal3fv, :void
		gl_import :glNormal3iv, :void
		gl_import :glNormal3sv, :void
		gl_import :glIndexd, :void
		gl_import :glIndexf, :void
		gl_import :glIndexi, :void
		gl_import :glIndexs, :void
		gl_import :glIndexub, :void
		gl_import :glIndexdv, :void
		gl_import :glIndexfv, :void
		gl_import :glIndexiv, :void
		gl_import :glIndexsv, :void
		gl_import :glIndexubv, :void
		gl_import :glColor3b, :void
		gl_import :glColor3d, :void
		gl_import :glColor3f, :void
		gl_import :glColor3i, :void
		gl_import :glColor3s, :void
		gl_import :glColor3ub, :void
		gl_import :glColor3ui, :void
		gl_import :glColor3us, :void
		gl_import :glColor4b, :void
		gl_import :glColor4d, :void
		gl_import :glColor4f, :void
		gl_import :glColor4i, :void
		gl_import :glColor4s, :void
		gl_import :glColor4ub, :void
		gl_import :glColor4ui, :void
		gl_import :glColor4us, :void
		gl_import :glColor3bv, :void
		gl_import :glColor3dv, :void
		gl_import :glColor3fv, :void
		gl_import :glColor3iv, :void
		gl_import :glColor3sv, :void
		gl_import :glColor3ubv, :void
		gl_import :glColor3uiv, :void
		gl_import :glColor3usv, :void
		gl_import :glColor4bv, :void
		gl_import :glColor4dv, :void
		gl_import :glColor4fv, :void
		gl_import :glColor4iv, :void
		gl_import :glColor4sv, :void
		gl_import :glColor4ubv, :void
		gl_import :glColor4uiv, :void
		gl_import :glColor4usv, :void
		gl_import :glTexCoord1d, :void
		gl_import :glTexCoord1f, :void
		gl_import :glTexCoord1i, :void
		gl_import :glTexCoord1s, :void
		gl_import :glTexCoord2d, :void
		gl_import :glTexCoord2f, :void
		gl_import :glTexCoord2i, :void
		gl_import :glTexCoord2s, :void
		gl_import :glTexCoord3d, :void
		gl_import :glTexCoord3f, :void
		gl_import :glTexCoord3i, :void
		gl_import :glTexCoord3s, :void
		gl_import :glTexCoord4d, :void
		gl_import :glTexCoord4f, :void
		gl_import :glTexCoord4i, :void
		gl_import :glTexCoord4s, :void
		gl_import :glTexCoord1dv, :void
		gl_import :glTexCoord1fv, :void
		gl_import :glTexCoord1iv, :void
		gl_import :glTexCoord1sv, :void
		gl_import :glTexCoord2dv, :void
		gl_import :glTexCoord2fv, :void
		gl_import :glTexCoord2iv, :void
		gl_import :glTexCoord2sv, :void
		gl_import :glTexCoord3dv, :void
		gl_import :glTexCoord3fv, :void
		gl_import :glTexCoord3iv, :void
		gl_import :glTexCoord3sv, :void
		gl_import :glTexCoord4dv, :void
		gl_import :glTexCoord4fv, :void
		gl_import :glTexCoord4iv, :void
		gl_import :glTexCoord4sv, :void
		gl_import :glRasterPos2d, :void
		gl_import :glRasterPos2f, :void
		gl_import :glRasterPos2i, :void
		gl_import :glRasterPos2s, :void
		gl_import :glRasterPos3d, :void
		gl_import :glRasterPos3f, :void
		gl_import :glRasterPos3i, :void
		gl_import :glRasterPos3s, :void
		gl_import :glRasterPos4d, :void
		gl_import :glRasterPos4f, :void
		gl_import :glRasterPos4i, :void
		gl_import :glRasterPos4s, :void
		gl_import :glRasterPos2dv, :void
		gl_import :glRasterPos2fv, :void
		gl_import :glRasterPos2iv, :void
		gl_import :glRasterPos2sv, :void
		gl_import :glRasterPos3dv, :void
		gl_import :glRasterPos3fv, :void
		gl_import :glRasterPos3iv, :void
		gl_import :glRasterPos3sv, :void
		gl_import :glRasterPos4dv, :void
		gl_import :glRasterPos4fv, :void
		gl_import :glRasterPos4iv, :void
		gl_import :glRasterPos4sv, :void
		gl_import :glRectd, :void
		gl_import :glRectf, :void
		gl_import :glRecti, :void
		gl_import :glRects, :void
		gl_import :glRectdv, :void
		gl_import :glRectfv, :void
		gl_import :glRectiv, :void
		gl_import :glRectsv, :void
		gl_import :glShadeModel, :void
		gl_import :glLightf, :void
		gl_import :glLighti, :void
		gl_import :glLightfv, :void
		gl_import :glLightiv, :void
		gl_import :glGetLightfv, :void
		gl_import :glGetLightiv, :void
		gl_import :glLightModelf, :void
		gl_import :glLightModeli, :void
		gl_import :glLightModelfv, :void
		gl_import :glLightModeliv, :void
		gl_import :glMaterialf, :void
		gl_import :glMateriali, :void
		gl_import :glMaterialfv, :void
		gl_import :glMaterialiv, :void
		gl_import :glGetMaterialfv, :void
		gl_import :glGetMaterialiv, :void
		gl_import :glColorMaterial, :void
		gl_import :glPixelZoom, :void
		gl_import :glPixelStoref, :void
		gl_import :glPixelStorei, :void
		gl_import :glPixelTransferf, :void
		gl_import :glPixelTransferi, :void
		gl_import :glPixelMapfv, :void
		gl_import :glPixelMapuiv, :void
		gl_import :glPixelMapusv, :void
		gl_import :glGetPixelMapfv, :void
		gl_import :glGetPixelMapuiv, :void
		gl_import :glGetPixelMapusv, :void
		gl_import :glBitmap, :void
		gl_import :glReadPixels, :void
		gl_import :glDrawPixels, :void
		gl_import :glCopyPixels, :void
		gl_import :glStencilFunc, :void
		gl_import :glStencilMask, :void
		gl_import :glStencilOp, :void
		gl_import :glClearStencil, :void
		gl_import :glTexGend, :void
		gl_import :glTexGenf, :void
		gl_import :glTexGeni, :void
		gl_import :glTexGendv, :void
		gl_import :glTexGenfv, :void
		gl_import :glTexGeniv, :void
		gl_import :glGetTexGendv, :void
		gl_import :glGetTexGenfv, :void
		gl_import :glGetTexGeniv, :void
		gl_import :glTexEnvf, :void
		gl_import :glTexEnvi, :void
		gl_import :glTexEnvfv, :void
		gl_import :glTexEnviv, :void
		gl_import :glGetTexEnvfv, :void
		gl_import :glGetTexEnviv, :void
		gl_import :glTexParameterf, :void
		gl_import :glTexParameteri, :void
		gl_import :glTexParameterfv, :void
		gl_import :glTexParameteriv, :void
		gl_import :glGetTexParameterfv, :void
		gl_import :glGetTexParameteriv, :void
		gl_import :glGetTexLevelParameterfv, :void
		gl_import :glGetTexLevelParameteriv, :void
		gl_import :glTexImage1D, :void
		gl_import :glTexImage2D, :void
		gl_import :glGetTexImage, :void
		gl_import :glMap1d, :void
		gl_import :glMap1f, :void
		gl_import :glMap2d, :void
		gl_import :glMap2f, :void
		gl_import :glGetMapdv, :void
		gl_import :glGetMapfv, :void
		gl_import :glGetMapiv, :void
		gl_import :glEvalCoord1d, :void
		gl_import :glEvalCoord1f, :void
		gl_import :glEvalCoord1dv, :void
		gl_import :glEvalCoord1fv, :void
		gl_import :glEvalCoord2d, :void
		gl_import :glEvalCoord2f, :void
		gl_import :glEvalCoord2dv, :void
		gl_import :glEvalCoord2fv, :void
		gl_import :glMapGrid1d, :void
		gl_import :glMapGrid1f, :void
		gl_import :glMapGrid2d, :void
		gl_import :glMapGrid2f, :void
		gl_import :glEvalPoint1, :void
		gl_import :glEvalPoint2, :void
		gl_import :glEvalMesh1, :void
		gl_import :glEvalMesh2, :void
		gl_import :glFogf, :void
		gl_import :glFogi, :void
		gl_import :glFogfv, :void
		gl_import :glFogiv, :void
		gl_import :glFeedbackBuffer, :void
		gl_import :glPassThrough, :void
		gl_import :glSelectBuffer, :void
		gl_import :glInitNames, :void
		gl_import :glLoadName, :void
		gl_import :glPushName, :void
		gl_import :glPopName, :void
		gl_import :glGenTextures, :void
		gl_import :glDeleteTextures, :void
		gl_import :glBindTexture, :void
		gl_import :glPrioritizeTextures, :void
		gl_import :glAreTexturesResident, :GLboolean
		gl_import :glIsTexture, :GLboolean
		gl_import :glTexSubImage1D, :void
		gl_import :glTexSubImage2D, :void
		gl_import :glCopyTexImage1D, :void
		gl_import :glCopyTexImage2D, :void
		gl_import :glCopyTexSubImage1D, :void
		gl_import :glCopyTexSubImage2D, :void
		gl_import :glVertexPointer, :void
		gl_import :glNormalPointer, :void
		gl_import :glColorPointer, :void
		gl_import :glIndexPointer, :void
		gl_import :glTexCoordPointer, :void
		gl_import :glEdgeFlagPointer, :void
		gl_import :glGetPointerv, :void
		gl_import :glArrayElement, :void
		gl_import :glDrawArrays, :void
		gl_import :glDrawElements, :void
		gl_import :glInterleavedArrays, :void
		
		#
		# OpenGL 1.2
		#
		gl_import :glCopyTexSubImage3D, :void
		gl_import :glDrawRangeElements, :void
		gl_import :glTexImage3D, :void
		gl_import :glTexSubImage3D, :void

		#
		# OpenGL 1.3
		#
		gl_import :glActiveTexture, :void
		gl_import :glClientActiveTexture, :void
		gl_import :glCompressedTexImage1D, :void
		gl_import :glCompressedTexImage2D, :void
		gl_import :glCompressedTexImage3D, :void
		gl_import :glCompressedTexSubImage1D, :void
		gl_import :glCompressedTexSubImage2D, :void
		gl_import :glCompressedTexSubImage3D, :void
		gl_import :glGetCompressedTexImage, :void
		gl_import :glLoadTransposeMatrixd, :void
		gl_import :glLoadTransposeMatrixf, :void
		gl_import :glMultTransposeMatrixd, :void
		gl_import :glMultTransposeMatrixf, :void
		gl_import :glMultiTexCoord1d, :void
		gl_import :glMultiTexCoord1dv, :void
		gl_import :glMultiTexCoord1f, :void
		gl_import :glMultiTexCoord1fv, :void
		gl_import :glMultiTexCoord1i, :void
		gl_import :glMultiTexCoord1iv, :void
		gl_import :glMultiTexCoord1s, :void
		gl_import :glMultiTexCoord1sv, :void
		gl_import :glMultiTexCoord2d, :void
		gl_import :glMultiTexCoord2dv, :void
		gl_import :glMultiTexCoord2f, :void
		gl_import :glMultiTexCoord2fv, :void
		gl_import :glMultiTexCoord2i, :void
		gl_import :glMultiTexCoord2iv, :void
		gl_import :glMultiTexCoord2s, :void
		gl_import :glMultiTexCoord2sv, :void
		gl_import :glMultiTexCoord3d, :void
		gl_import :glMultiTexCoord3dv, :void
		gl_import :glMultiTexCoord3f, :void
		gl_import :glMultiTexCoord3fv, :void
		gl_import :glMultiTexCoord3i, :void
		gl_import :glMultiTexCoord3iv, :void
		gl_import :glMultiTexCoord3s, :void
		gl_import :glMultiTexCoord3sv, :void
		gl_import :glMultiTexCoord4d, :void
		gl_import :glMultiTexCoord4dv, :void
		gl_import :glMultiTexCoord4f, :void
		gl_import :glMultiTexCoord4fv, :void
		gl_import :glMultiTexCoord4i, :void
		gl_import :glMultiTexCoord4iv, :void
		gl_import :glMultiTexCoord4s, :void
		gl_import :glMultiTexCoord4sv, :void
		gl_import :glSampleCoverage, :void

		#
		# OpenGL 1.4
		#
		gl_import :glBlendColor, :void
		gl_import :glBlendEquation, :void
		gl_import :glBlendFuncSeparate, :void
		gl_import :glFogCoordPointer, :void
		gl_import :glFogCoordd, :void
		gl_import :glFogCoorddv, :void
		gl_import :glFogCoordf, :void
		gl_import :glFogCoordfv, :void
		gl_import :glMultiDrawArrays, :void
		gl_import :glMultiDrawElements, :void
		gl_import :glPointParameterf, :void
		gl_import :glPointParameterfv, :void
		gl_import :glPointParameteri, :void
		gl_import :glPointParameteriv, :void
		gl_import :glSecondaryColor3b, :void
		gl_import :glSecondaryColor3bv, :void
		gl_import :glSecondaryColor3d, :void
		gl_import :glSecondaryColor3dv, :void
		gl_import :glSecondaryColor3f, :void
		gl_import :glSecondaryColor3fv, :void
		gl_import :glSecondaryColor3i, :void
		gl_import :glSecondaryColor3iv, :void
		gl_import :glSecondaryColor3s, :void
		gl_import :glSecondaryColor3sv, :void
		gl_import :glSecondaryColor3ub, :void
		gl_import :glSecondaryColor3ubv, :void
		gl_import :glSecondaryColor3ui, :void
		gl_import :glSecondaryColor3uiv, :void
		gl_import :glSecondaryColor3us, :void
		gl_import :glSecondaryColor3usv, :void
		gl_import :glSecondaryColorPointer, :void
		gl_import :glWindowPos2d, :void
		gl_import :glWindowPos2dv, :void
		gl_import :glWindowPos2f, :void
		gl_import :glWindowPos2fv, :void
		gl_import :glWindowPos2i, :void
		gl_import :glWindowPos2iv, :void
		gl_import :glWindowPos2s, :void
		gl_import :glWindowPos2sv, :void
		gl_import :glWindowPos3d, :void
		gl_import :glWindowPos3dv, :void
		gl_import :glWindowPos3f, :void
		gl_import :glWindowPos3fv, :void
		gl_import :glWindowPos3i, :void
		gl_import :glWindowPos3iv, :void
		gl_import :glWindowPos3s, :void
		gl_import :glWindowPos3sv, :void

		#
		# OpenGL 1.5
		#
		gl_import :glBeginQuery, :void
		gl_import :glBindBuffer, :void
		gl_import :glBufferData, :void
		gl_import :glBufferSubData, :void
		gl_import :glDeleteBuffers, :void
		gl_import :glDeleteQueries, :void
		gl_import :glEndQuery, :void
		gl_import :glGenBuffers, :void
		gl_import :glGenQueries, :void
		gl_import :glGetBufferParameteriv, :void
		gl_import :glGetBufferPointerv, :void
		gl_import :glGetBufferSubData, :void
		gl_import :glGetQueryObjectiv, :void
		gl_import :glGetQueryObjectuiv, :void
		gl_import :glGetQueryiv, :void
		gl_import :glIsBuffer, :int
		gl_import :glIsQuery, :int
		gl_import :glMapBuffer, :pointer
		gl_import :glUnmapBuffer, :int

		#
		# OpenGL 2.0
		#
		gl_import :glAttachShader, :void
		gl_import :glBindAttribLocation, :void
		gl_import :glBlendEquationSeparate, :void
		gl_import :glCompileShader, :void
		gl_import :glCreateProgram, :GLuint
		gl_import :glCreateShader, :GLuint
		gl_import :glDeleteProgram, :void
		gl_import :glDeleteShader, :void
		gl_import :glDetachShader, :void
		gl_import :glDisableVertexAttribArray, :void
		gl_import :glDrawBuffers, :void
		gl_import :glEnableVertexAttribArray, :void
		gl_import :glGetActiveAttrib, :void
		gl_import :glGetActiveUniform, :void
		gl_import :glGetAttachedShaders, :void
		gl_import :glGetAttribLocation, :GLint
		gl_import :glGetProgramInfoLog, :void
		gl_import :glGetProgramiv, :void
		gl_import :glGetShaderInfoLog, :void
		gl_import :glGetShaderSource, :void
		gl_import :glGetShaderiv, :void
		gl_import :glGetUniformLocation, :GLint
		gl_import :glGetUniformfv, :void
		gl_import :glGetUniformiv, :void
		gl_import :glGetVertexAttribPointerv, :void
		gl_import :glGetVertexAttribdv, :void
		gl_import :glGetVertexAttribfv, :void
		gl_import :glGetVertexAttribiv, :void
		gl_import :glIsProgram, :int
		gl_import :glIsShader, :int
		gl_import :glLinkProgram, :void
		gl_import :glShaderSource, :void
		gl_import :glStencilFuncSeparate, :void
		gl_import :glStencilMaskSeparate, :void
		gl_import :glStencilOpSeparate, :void
		gl_import :glUniform1f, :void
		gl_import :glUniform1fv, :void
		gl_import :glUniform1i, :void
		gl_import :glUniform1iv, :void
		gl_import :glUniform2f, :void
		gl_import :glUniform2fv, :void
		gl_import :glUniform2i, :void
		gl_import :glUniform2iv, :void
		gl_import :glUniform3f, :void
		gl_import :glUniform3fv, :void
		gl_import :glUniform3i, :void
		gl_import :glUniform3iv, :void
		gl_import :glUniform4f, :void
		gl_import :glUniform4fv, :void
		gl_import :glUniform4i, :void
		gl_import :glUniform4iv, :void
		gl_import :glUniformMatrix2fv, :void
		gl_import :glUniformMatrix3fv, :void
		gl_import :glUniformMatrix4fv, :void
		gl_import :glUseProgram, :void
		gl_import :glValidateProgram, :void
		gl_import :glVertexAttrib1d, :void
		gl_import :glVertexAttrib1dv, :void
		gl_import :glVertexAttrib1f, :void
		gl_import :glVertexAttrib1fv, :void
		gl_import :glVertexAttrib1s, :void
		gl_import :glVertexAttrib1sv, :void
		gl_import :glVertexAttrib2d, :void
		gl_import :glVertexAttrib2dv, :void
		gl_import :glVertexAttrib2f, :void
		gl_import :glVertexAttrib2fv, :void
		gl_import :glVertexAttrib2s, :void
		gl_import :glVertexAttrib2sv, :void
		gl_import :glVertexAttrib3d, :void
		gl_import :glVertexAttrib3dv, :void
		gl_import :glVertexAttrib3f, :void
		gl_import :glVertexAttrib3fv, :void
		gl_import :glVertexAttrib3s, :void
		gl_import :glVertexAttrib3sv, :void
		gl_import :glVertexAttrib4Nbv, :void
		gl_import :glVertexAttrib4Niv, :void
		gl_import :glVertexAttrib4Nsv, :void
		gl_import :glVertexAttrib4Nub, :void
		gl_import :glVertexAttrib4Nubv, :void
		gl_import :glVertexAttrib4Nuiv, :void
		gl_import :glVertexAttrib4Nusv, :void
		gl_import :glVertexAttrib4bv, :void
		gl_import :glVertexAttrib4d, :void
		gl_import :glVertexAttrib4dv, :void
		gl_import :glVertexAttrib4f, :void
		gl_import :glVertexAttrib4fv, :void
		gl_import :glVertexAttrib4iv, :void
		gl_import :glVertexAttrib4s, :void
		gl_import :glVertexAttrib4sv, :void
		gl_import :glVertexAttrib4ubv, :void
		gl_import :glVertexAttrib4uiv, :void
		gl_import :glVertexAttrib4usv, :void
		gl_import :glVertexAttribPointer, :void

		#
		# OpenGL 2.1
		#
		gl_import :glUniformMatrix2x3fv, :void
		gl_import :glUniformMatrix2x4fv, :void
		gl_import :glUniformMatrix3x2fv, :void
		gl_import :glUniformMatrix3x4fv, :void
		gl_import :glUniformMatrix4x2fv, :void
		gl_import :glUniformMatrix4x3fv, :void

		#
		# OpenGL 3.0
		#
		gl_import :glBeginConditionalRender, :void
		gl_import :glBeginTransformFeedback, :void
		gl_import :glBindFragDataLocation, :void
		gl_import :glClampColor, :void
		gl_import :glClearBufferfi, :void
		gl_import :glClearBufferfv, :void
		gl_import :glClearBufferiv, :void
		gl_import :glClearBufferuiv, :void
		gl_import :glColorMaski, :void
		gl_import :glDisablei, :void
		gl_import :glEnablei, :void
		gl_import :glEndConditionalRender, :void
		gl_import :glEndTransformFeedback, :void
		gl_import :glGetBooleani_v, :void
		gl_import :glGetFragDataLocation, :GLint
		gl_import :glGetStringi, :void
		gl_import :glGetTexParameterIiv, :void
		gl_import :glGetTexParameterIuiv, :void
		gl_import :glGetTransformFeedbackVarying, :void
		gl_import :glGetUniformuiv, :void
		gl_import :glGetVertexAttribIiv, :void
		gl_import :glGetVertexAttribIuiv, :void
		gl_import :glIsEnabledi, :int
		gl_import :glTexParameterIiv, :void
		gl_import :glTexParameterIuiv, :void
		gl_import :glTransformFeedbackVaryings, :void
		gl_import :glUniform1ui, :void
		gl_import :glUniform1uiv, :void
		gl_import :glUniform2ui, :void
		gl_import :glUniform2uiv, :void
		gl_import :glUniform3ui, :void
		gl_import :glUniform3uiv, :void
		gl_import :glUniform4ui, :void
		gl_import :glUniform4uiv, :void
		gl_import :glVertexAttribI1i, :void
		gl_import :glVertexAttribI1iv, :void
		gl_import :glVertexAttribI1ui, :void
		gl_import :glVertexAttribI1uiv, :void
		gl_import :glVertexAttribI2i, :void
		gl_import :glVertexAttribI2iv, :void
		gl_import :glVertexAttribI2ui, :void
		gl_import :glVertexAttribI2uiv, :void
		gl_import :glVertexAttribI3i, :void
		gl_import :glVertexAttribI3iv, :void
		gl_import :glVertexAttribI3ui, :void
		gl_import :glVertexAttribI3uiv, :void
		gl_import :glVertexAttribI4bv, :void
		gl_import :glVertexAttribI4i, :void
		gl_import :glVertexAttribI4iv, :void
		gl_import :glVertexAttribI4sv, :void
		gl_import :glVertexAttribI4ubv, :void
		gl_import :glVertexAttribI4ui, :void
		gl_import :glVertexAttribI4uiv, :void
		gl_import :glVertexAttribI4usv, :void
		gl_import :glVertexAttribIPointer, :void

		#
		# OpenGL 3.1
		#
		gl_import :glDrawArraysInstanced, :void
		gl_import :glDrawElementsInstanced, :void
		gl_import :glPrimitiveRestartIndex, :void
		gl_import :glTexBuffer, :void

		#
		# OpenGL 3.2
		#
		gl_import :glFramebufferTexture, :void
		gl_import :glGetBufferParameteri64v, :void
		gl_import :glGetInteger64i_v, :void

		#
		# OpenGL 3.3
		#
		gl_import :glVertexAttribDivisor, :void

		#
		# OpenGL 4.0
		#
		gl_import :glBlendEquationSeparatei, :void
		gl_import :glBlendEquationi, :void
		gl_import :glBlendFuncSeparatei, :void
		gl_import :glBlendFunci, :void
		gl_import :glMinSampleShading, :void

		#
		# OpenGL 4.5
		#
		gl_import :glGetGraphicsResetStatus, :GLenum
		gl_import :glGetnCompressedTexImage, :void
		gl_import :glGetnTexImage, :void
		gl_import :glGetnUniformdv, :void
	end
end