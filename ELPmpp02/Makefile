PROGRAM = ELPmpp02
SRCS = ELPMPP02.for
OBJS = $(SRCS:.for=.o)

BUILD_DIR = forx
OBJECTS = $(OBJS:%=$(BUILD_DIR)/%)

FC = gfortran
C_FLAGS = -fno-align-commons
L_FLAGS =

all: $(PROGRAM)

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(PROGRAM)
	rm -f ELPMPP02.TXT

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(OBJECTS) : $(SRCS) | $(BUILD_DIR)
	$(FC) -c $(C_FLAGS) $< -o $@

$(PROGRAM): $(OBJECTS)
	$(FC) $(L_FLAGS) $(OBJECTS) -o $(PROGRAM)

run: $(PROGRAM)
	./$(PROGRAM)
