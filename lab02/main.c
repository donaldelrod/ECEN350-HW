extern long long int test();
extern void lab02b();
extern void lab02c(long long int a);
extern long long int lab02d(long long int a);

int main(void)
{
	test();
	lab02b();
	lab02c(100);
	int q = lab02d(100);
	//printf("The number %d in hex is %02x\n", 100, lab02c(100));
	//printf("Address of %d + 1000 is: %08x\n", 100, lab02d(100));
    return 0;
}
