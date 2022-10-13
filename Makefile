SRCS = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s \
	   ft_atoi_base.s ft_list_push_front.s ft_list_size.s ft_list_sort.s ft_list_remove_if.s

OBJS = $(SRCS:.s=.o)

NAME = libasm.a

ASMC = nasm
ASMFLAGS = -f macho64 -g

CC = gcc
# CFLAGS = -g -fsanitize=address

SHELL = zsh

AQUA = \033[0;96m
AQUA_BOLD = \033[1;96m

PURPLE = \033[0;95m
PURPLE_BOLD = \033[1;95m

GREEN = \033[0;92m
GREEN_BOLD = \033[1;92m
GREEN_UNDRLINE = \033[4;32m

RED = \033[0;91m
IRED = \033[0;31m
RED_BOLD = \033[1;91m

YELLOW = \033[0;33m

SAME_LINE = \033[0G\033[2K

RESET = \033[0m

%.o: %.s
	@$(ASMC) $(ASMFLAGS) $< -o $@
	@echo -n "$(SAME_LINE)$(AQUA)Compiling $(AQUA_BOLD)$< $(RESET)"

%.o: %.c
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo -n "$(SAME_LINE)$(AQUA)Compiling $(AQUA_BOLD)$< $(RESET)"

$(NAME):	$(OBJS)
	@echo
	@echo "$(PURPLE)Linking *.o into $(PURPLE_BOLD)$(NAME)$(RESET)"
	@ar rcs $(NAME) $(OBJS)
	@echo "$(GREEN_BOLD)Done compiling $(GREEN_UNDERLINE)$(NAME)"

test: $(NAME)
	@echo "$(AQUA)Compiling $(AQUA_BOLD)main.c $(RESET)"
	@$(CC) $(CFLAGS) main.c $(NAME) -o test
	@echo "$(PURPLE)Linking *.o and main.o into $(PURPLE_BOLD)test $(RESET)"

all: test

bonus: all

clean:
	@rm -f $(OBJS)
	@echo "$(RED)Removing $(IRED)*.o$(RESET)"

fclean:		clean
	@rm -f $(NAME)
	@echo "$(RED)Removing $(IRED)$(NAME)$(RESET)"

re:			fclean all

.PHONY:	all clean fclean re