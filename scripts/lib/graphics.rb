=begin

	graphics.rb

	Mudan�as (quase reescrita na verdade) do m�dulo gr�fico para usar OpenGL
	no desenho

=end

#==============================================================================
# Graphics
#------------------------------------------------------------------------------
# M�dulo respons�vel por desenhar tudo na tela
#==============================================================================
module Graphics
    #--------------------------------------------------------------------------
    # Vari�veis est�ticas
    #--------------------------------------------------------------------------
	@@background = Color.new(0, 0, 0, 255)
	@@_set_up = false
	@@width = 544
	@@height = 416
	
    class << self
		#----------------------------------------------------------------------
		# Inicializa��o dos gr�ficos
		#----------------------------------------------------------------------
		def setup
			@@_set_up = true

			# �rea de vis�o
			glViewport 0, 0, width, height
			
			# Matriz de corre��o para que X/Y = 1
			apply_matrix
			
			# Matriz de vis�o de modelo (identidade)
			glMatrixMode GL_MODELVIEW
			glLoadIdentity
			
			# Transpar�ncia
			glEnable GL_BLEND
			glBlendFunc GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA
		end
		#----------------------------------------------------------------------
		# Aplica uma matriz aos gr�ficos para corrigir a escala X/Y para 1
		#----------------------------------------------------------------------
		def apply_matrix
			glMatrixMode GL_PROJECTION
			
			s = 1.0 / height * width
			glLoadMatrixf [
				1, 0, 0, 0,
				0, s, 0, 0,
				0, 0, 1, 0,
				0, 0, 0, 1
			].pack('f16').cptr
		end
		private :apply_matrix
		#----------------------------------------------------------------------
		# Limpeza da tela
		#----------------------------------------------------------------------
		def clear
			if background.alpha != 255
				glMatrixMode GL_PROJECTION
				glPushMatrix
				glLoadIdentity
			
				glMatrixMode GL_MODELVIEW
				glPushMatrix
				glLoadIdentity
				
				glColor4f *background.to_4f
				glBegin GL_QUADS
					glVertex2i -1.0,  1.0
					glVertex2i  1.0,  1.0
					glVertex2i  1.0, -1.0
					glVertex2i -1.0, -1.0
				glEnd
				
				glPopMatrix
				
				glMatrixMode GL_PROJECTION
				glPopMatrix
			else
				glClearColor *background.to_4f
				glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
			end

            # Limpa a matriz
			#glMatrixMode GL_MODELVIEW
            #glLoadIdentity
		end
        #----------------------------------------------------------------------
        # Atualiza��o da tela
        #----------------------------------------------------------------------
        alias upd update
        def update
			unless @@_set_up
				raise "Graphics module not initialized. n" + 
					  "Call `Graphics.setup` before `Graphics.update`"
			end
		
            t = Time.now
			
            # Troca os buffers de desenho e exibi��o (double buffering \o/)
			#
			# Isso vai mostrar tudo que foi desenhado durante este frame na 
			# tela do jogo
            SwapBuffers(@@hdc)

            # Espera um frame
            frame = 1.0 / frame_rate
            until (Time.now - t) >= frame #&& GetActiveWindow() == @@hwnd
                # ...
            end
			
			# Limpa a tela
			clear
			
            self.frame_count += 1
        end
        #----------------------------------------------------------------------
        # Aplica fadein na tela
        #----------------------------------------------------------------------
        def fadein *args
        end
        #----------------------------------------------------------------------
        # Aplica fadeout na tela
        #----------------------------------------------------------------------
        def fadeout *args
        end
        #----------------------------------------------------------------------
        # Aplica uma transi��o na tela
        #----------------------------------------------------------------------
        def transition *args
        end
        #----------------------------------------------------------------------
        # Handle de contexto de dispositivo
        #----------------------------------------------------------------------
        def hdc
            return @@hdc
        end
        #----------------------------------------------------------------------
        # Handle de contexto do WGL
        #----------------------------------------------------------------------
        def hglrc
            return @@hglrc
        end
        #----------------------------------------------------------------------
        # Handle da janela
        #----------------------------------------------------------------------
        def hwnd
            return @@hwnd
        end
		#----------------------------------------------------------------------
		# Cor do fundo da tela
		#----------------------------------------------------------------------
		def background
			return @@background
		end
		#----------------------------------------------------------------------
		# Define a cor de fundo da tela
		#----------------------------------------------------------------------
		def background= color
			@@background = color
		end
		#----------------------------------------------------------------------
		# Redimensiona a tela
		#----------------------------------------------------------------------
		def resize_screen width, height
			window_rect = RECT.new
			GetWindowRect @@hwnd, window_rect.cptr
			
			window_style = GetWindowLong @@hwnd, -16
			window_ex_style = GetWindowLong @@hwnd, -20
			
			left = window_rect[:left].unpack('L').first
			top = window_rect[:top].unpack('L').first
			
			window_rect[:right] = left + width
			window_rect[:bottom] = top + height
			
			AdjustWindowRectEx(
				window_rect.cptr, 
				window_style,
				0, 					# Sem menu
				window_ex_style
			)
			
			right = window_rect[:right].unpack('L').first
			bottom = window_rect[:bottom].unpack('L').first
			
			MoveWindow(
				@@hwnd,
				left,
				top,
				right - left,
				bottom - top,
				0
			)
			
			@@width = width
			@@height = height
			
			glViewport 0, 0, width, height
			
			glMatrixMode GL_PROJECTION
			glLoadIdentity
			apply_matrix
		end
		#----------------------------------------------------------------------
		# Obt�m a largura da tela
		#----------------------------------------------------------------------
		def width
			return @@width
		end
		#----------------------------------------------------------------------
		# Obt�m a altura da tela
		#----------------------------------------------------------------------
		def height
			return @@height
		end
    end
end